import ARKit
import AVFoundation
import CoreML
import Flutter
import RoomPlan
import UIKit
import Vision

private func matrixValues(_ value: simd_float4x4) -> [Double] {
  let columns = [value.columns.0, value.columns.1, value.columns.2, value.columns.3]
  return columns.flatMap { [Double($0.x), Double($0.y), Double($0.z), Double($0.w)] }
}

private func captureHeader(in view: UIView) {
  let header = UILabel()
  header.translatesAutoresizingMaskIntoConstraints = false
  header.backgroundColor = .white
  header.textColor = .black
  header.layer.borderColor = UIColor.black.cgColor
  header.layer.borderWidth = 2
  header.layer.cornerRadius = 6
  header.clipsToBounds = true
  header.numberOfLines = 2
  header.font = .boldSystemFont(ofSize: 15)
  header.text = "  SCANNING WORKSPACE\n  Move slowly and capture every wall"
  view.addSubview(header)
  NSLayoutConstraint.activate([
    header.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
    header.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
    header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
    header.heightAnchor.constraint(equalToConstant: 62),
  ])
}

private func styleProgressCard(_ label: UILabel, in view: UIView, text: String) {
  label.frame = CGRect(x: 16, y: view.bounds.height - 225,
                       width: view.bounds.width - 32, height: 112)
  label.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
  label.backgroundColor = .white
  label.textColor = .black
  label.layer.borderColor = UIColor.black.cgColor
  label.layer.borderWidth = 2
  label.layer.cornerRadius = 6
  label.layer.shadowColor = UIColor.black.cgColor
  label.layer.shadowOffset = CGSize(width: 5, height: 6)
  label.layer.shadowOpacity = 1
  label.layer.shadowRadius = 0
  label.numberOfLines = 4
  label.font = .systemFont(ofSize: 14, weight: .semibold)
  label.text = text
  view.addSubview(label)
}

final class ShelfScanner: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  private var presenter: UIViewController? {
    UIApplication.shared.connectedScenes
      .compactMap { $0 as? UIWindowScene }
      .flatMap { $0.windows }
      .first(where: { $0.isKeyWindow })?.rootViewController
  }
  private var pending: FlutterResult?
  private var roomController: UIViewController?
  private var picker: UIImagePickerController?

  func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "capabilities":
      let backend: String
      if #available(iOS 16.0, *), RoomCaptureSession.isSupported {
        backend = "roomplan"
      } else if ARWorldTrackingConfiguration.isSupported {
        backend = "arkit"
      } else {
        backend = "unsupported"
      }
      result(["roomBackend": backend,
              "itemCamera": UIImagePickerController.isSourceTypeAvailable(.camera),
              "semanticStorage": ShelfARController.hasDetector])
    case "startRoom":
      var roomSupported = ARWorldTrackingConfiguration.isSupported
      if #available(iOS 16.0, *), RoomCaptureSession.isSupported { roomSupported = true }
      guard roomSupported else {
        result(FlutterError(code: "unsupported", message: "Room tracking is not supported on this device.", details: nil))
        return
      }
      authorizeCamera(result: result) { [weak self] in self?.startRoom(result: result) }
    case "startItems":
      guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
        result(FlutterError(code: "unavailable", message: "A physical camera is required for item capture.", details: nil))
        return
      }
      authorizeCamera(result: result) { [weak self] in self?.startItems(result: result) }
    case "cancel":
      roomController?.dismiss(animated: true)
      picker?.dismiss(animated: true)
      finish(error: FlutterError(code: "cancelled", message: "Capture cancelled.", details: nil))
      result(nil)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func authorizeCamera(result: @escaping FlutterResult, next: @escaping () -> Void) {
    guard pending == nil else {
      result(FlutterError(code: "busy", message: "A capture is already active.", details: nil)); return
    }
    switch AVCaptureDevice.authorizationStatus(for: .video) {
    case .authorized: next()
    case .notDetermined:
      AVCaptureDevice.requestAccess(for: .video) { granted in
        DispatchQueue.main.async {
          if granted { next() }
          else { result(FlutterError(code: "permissionDenied", message: "Camera access was denied.", details: nil)) }
        }
      }
    default:
      result(FlutterError(code: "permissionDenied", message: "Enable camera access in Settings.", details: nil))
    }
  }

  private func startRoom(result: @escaping FlutterResult) {
    guard let presenter else {
      result(FlutterError(code: "unavailable", message: "No camera view is available.", details: nil)); return
    }
    let controller: UIViewController
    if #available(iOS 16.0, *), RoomCaptureSession.isSupported {
      controller = ShelfRoomPlanController()
    } else if ARWorldTrackingConfiguration.isSupported {
      controller = ShelfARController()
    } else {
      result(FlutterError(code: "unsupported", message: "Room tracking is not supported on this device.", details: nil)); return
    }
    pending = result
    roomController = controller
    let completion: (Result<[String: Any], Error>) -> Void = { [weak self] outcome in
      switch outcome {
      case .success(let room): self?.finish(value: room)
      case .failure(let error):
        let cancelled = (error as NSError).domain == "Shelf" && (error as NSError).code == 1
        self?.finish(error: FlutterError(code: cancelled ? "cancelled" : "captureFailed",
          message: error.localizedDescription, details: nil))
      }
    }
    if #available(iOS 16.0, *), let roomplan = controller as? ShelfRoomPlanController {
      roomplan.completion = completion
    }
    if let ar = controller as? ShelfARController { ar.completion = completion }
    controller.modalPresentationStyle = .fullScreen
    presenter.present(controller, animated: true)
  }

  private func startItems(result: @escaping FlutterResult) {
    guard UIImagePickerController.isSourceTypeAvailable(.camera), let presenter else {
      result(FlutterError(code: "unavailable", message: "A physical camera is required for item capture.", details: nil)); return
    }
    let picker = UIImagePickerController()
    picker.sourceType = .camera
    picker.delegate = self
    picker.modalPresentationStyle = .fullScreen
    self.picker = picker
    pending = result
    presenter.present(picker, animated: true)
  }

  private func finish(value: Any? = nil, error: FlutterError? = nil) {
    let callback = pending
    pending = nil
    roomController = nil
    picker = nil
    callback?(error ?? value)
  }

  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true)
    finish(error: FlutterError(code: "cancelled", message: "Capture cancelled.", details: nil))
  }

  func imagePickerController(_ picker: UIImagePickerController,
      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    picker.dismiss(animated: true)
    guard let image = info[.originalImage] as? UIImage, let cgImage = image.cgImage else {
      finish(error: FlutterError(code: "captureFailed", message: "No image was captured.", details: nil)); return
    }
    let textRequest = VNRecognizeTextRequest()
    textRequest.recognitionLevel = .accurate
    textRequest.usesLanguageCorrection = false
    let barcodeRequest = VNDetectBarcodesRequest()
    DispatchQueue.global(qos: .userInitiated).async { [weak self] in
      do {
        try VNImageRequestHandler(cgImage: cgImage).perform([textRequest, barcodeRequest])
        var suggestions: [[String: Any]] = []
        var seen = Set<String>()
        for barcode in barcodeRequest.results ?? [] {
          guard let value = barcode.payloadStringValue, !value.isEmpty, seen.insert(value).inserted else { continue }
          suggestions.append(["name": value, "identifier": value, "source": "barcode", "confidence": Double(barcode.confidence)])
        }
        for observation in textRequest.results ?? [] {
          guard let candidate = observation.topCandidates(1).first else { continue }
          let value = candidate.string.trimmingCharacters(in: .whitespacesAndNewlines)
          guard value.count >= 3, seen.insert(value).inserted else { continue }
          suggestions.append(["name": value, "identifier": "", "source": "ocr", "confidence": Double(candidate.confidence)])
        }
        DispatchQueue.main.async { self?.finish(value: suggestions) }
      } catch {
        DispatchQueue.main.async {
          self?.finish(error: FlutterError(code: "captureFailed", message: error.localizedDescription, details: nil))
        }
      }
    }
  }
}

@available(iOS 16.0, *)
private final class ShelfRoomPlanController: UIViewController, RoomCaptureViewDelegate {
  var completion: ((Result<[String: Any], Error>) -> Void)?
  private let captureView = RoomCaptureView(frame: .zero)
  private var cancelled = false
  private let status = UILabel()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .black
    captureView.frame = view.bounds
    captureView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    captureView.delegate = self
    view.addSubview(captureView)
    captureHeader(in: view)
    styleProgressCard(status, in: view,
      text: "  SCAN PROGRESS                         ACTIVE\n  RoomPlan is capturing room geometry\n  Review storage after finishing")
    addButton("Cancel", x: 16, action: #selector(cancel))
    addButton("Finish scan", x: 110, width: view.bounds.width - 126, action: #selector(finishScan))
  }
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    captureView.captureSession.run(configuration: RoomCaptureSession.Configuration())
  }
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    captureView.captureSession.stop()
  }
  private func addButton(_ title: String, x: CGFloat, width: CGFloat = 86, action: Selector) {
    let button = UIButton(type: .system)
    button.setTitle(title, for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.titleLabel?.font = .boldSystemFont(ofSize: 14)
    button.backgroundColor = title == "Finish scan" ? UIColor(red: 0.8, green: 1, blue: 0, alpha: 1) : .white
    button.layer.borderColor = UIColor.black.cgColor
    button.layer.borderWidth = 2
    button.layer.cornerRadius = 6
    button.frame = CGRect(x: x, y: view.bounds.height - 93, width: width, height: 48)
    button.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
    button.addTarget(self, action: action, for: .touchUpInside)
    view.addSubview(button)
  }
  @objc private func cancel() {
    cancelled = true
    captureView.captureSession.stop()
    dismiss(animated: true)
    completion?(.failure(NSError(domain: "Shelf", code: 1, userInfo: [NSLocalizedDescriptionKey: "Capture cancelled."])))
    completion = nil
  }
  @objc private func finishScan() { captureView.captureSession.stop() }
  func captureView(shouldPresent roomDataForProcessing: CapturedRoomData, error: Error?) -> Bool {
    if let error, !cancelled {
      completion?(.failure(error))
      completion = nil
      dismiss(animated: true)
      return false
    }
    return !cancelled
  }
  func captureView(didPresent room: CapturedRoom, error: Error?) {
    guard !cancelled else { return }
    if let error { completion?(.failure(error)); completion = nil; dismiss(animated: true); return }
    let surfaces: [[String: Any]] =
      [("wall", room.walls), ("door", room.doors), ("window", room.windows), ("opening", room.openings)]
      .flatMap { kind, values in values.map { surface in
        ["id": surface.identifier.uuidString, "kind": kind,
         "width": Double(surface.dimensions.x), "height": Double(surface.dimensions.y),
         "depth": Double(surface.dimensions.z),
         "transform": matrixValues(surface.transform)] as [String: Any]
      }}
    let storage: [[String: Any]] = room.objects.compactMap { object in
      let label = String(describing: object.category).lowercased()
      let kind: String
      if label.contains("cabinet") { kind = "Cabinet" }
      else if label.contains("storage") { kind = "Storage" }
      else if label.contains("shelf") { kind = "Shelf" }
      else { return nil }
      let confidence: Double = switch object.confidence {
      case .high: 0.9
      case .medium: 0.6
      case .low: 0.3
      }
      return ["id": object.identifier.uuidString, "kind": kind, "name": "",
        "source": "roomplan", "width": Double(object.dimensions.x),
        "height": Double(object.dimensions.y), "depth": Double(object.dimensions.z),
        "confidence": confidence, "transform": matrixValues(object.transform)]
    }
    completion?(.success(["backend": "roomplan", "surfaces": surfaces, "storage": storage]))
    completion = nil
    dismiss(animated: true)
  }
}

private final class ShelfARController: UIViewController, ARSessionDelegate {
  static var hasDetector: Bool {
    guard let url = Bundle.main.url(forResource: "StorageDetector", withExtension: "mlmodelc") else { return false }
    return (try? VNCoreMLModel(for: MLModel(contentsOf: url))) != nil
  }
  var completion: ((Result<[String: Any], Error>) -> Void)?
  private let sceneView = ARSCNView(frame: .zero)
  private var planes: [UUID: ARPlaneAnchor] = [:]
  private var marks: [[String: Any]] = []
  private var detections: [[String: Any]] = []
  private var detectionCounts: [String: Int] = [:]
  private var lastDetectionTime: TimeInterval = 0
  private var detecting = false
  private lazy var detector: VNCoreMLModel? = {
    guard let url = Bundle.main.url(forResource: "StorageDetector", withExtension: "mlmodelc"),
          let model = try? MLModel(contentsOf: url) else { return nil }
    return try? VNCoreMLModel(for: model)
  }()
  private var trackingMessage = "Move slowly to find walls and floor."
  private let status = UILabel()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .black
    sceneView.frame = view.bounds
    sceneView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    sceneView.session.delegate = self
    sceneView.session.delegateQueue = .main
    view.addSubview(sceneView)
    let reticle = UIView()
    reticle.translatesAutoresizingMaskIntoConstraints = false
    reticle.isUserInteractionEnabled = false
    reticle.layer.borderColor = UIColor(red: 0.8, green: 1, blue: 0, alpha: 1).cgColor
    reticle.layer.borderWidth = 3
    reticle.layer.cornerRadius = 20
    reticle.backgroundColor = UIColor.black.withAlphaComponent(0.16)
    view.addSubview(reticle)
    NSLayoutConstraint.activate([
      reticle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      reticle.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      reticle.widthAnchor.constraint(equalToConstant: 40),
      reticle.heightAnchor.constraint(equalToConstant: 40),
    ])
    let dot = UIView()
    dot.translatesAutoresizingMaskIntoConstraints = false
    dot.backgroundColor = UIColor(red: 0.8, green: 1, blue: 0, alpha: 1)
    dot.layer.cornerRadius = 3
    reticle.addSubview(dot)
    NSLayoutConstraint.activate([
      dot.centerXAnchor.constraint(equalTo: reticle.centerXAnchor),
      dot.centerYAnchor.constraint(equalTo: reticle.centerYAnchor),
      dot.widthAnchor.constraint(equalToConstant: 6),
      dot.heightAnchor.constraint(equalToConstant: 6),
    ])
    captureHeader(in: view)
    addButton("Cancel", x: 16, action: #selector(cancel))
    addButton("Mark storage", x: 110, width: 118, action: #selector(markStorage))
    addButton("Finish", x: 236, width: view.bounds.width - 252, action: #selector(finishScan))
    styleProgressCard(status, in: view,
      text: "  SCAN PROGRESS                         ACTIVE\n  0 room surfaces • 0 storage marks\n  \(trackingMessage)")
  }
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    let configuration = ARWorldTrackingConfiguration()
    configuration.planeDetection = [.horizontal, .vertical]
    if #available(iOS 13.4, *), ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
      configuration.sceneReconstruction = .mesh
    }
    sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
  }
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    sceneView.session.pause()
  }
  private func addButton(_ title: String, x: CGFloat, width: CGFloat = 82, action: Selector) {
    let button = UIButton(type: .system)
    button.setTitle(title, for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.titleLabel?.font = .boldSystemFont(ofSize: 12)
    button.backgroundColor = title == "Cancel" ? .white : UIColor(red: 0.8, green: 1, blue: 0, alpha: 1)
    button.layer.borderColor = UIColor.black.cgColor
    button.layer.borderWidth = 2
    button.layer.cornerRadius = 6
    button.frame = CGRect(x: x, y: view.bounds.height - 93, width: width, height: 48)
    button.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
    button.addTarget(self, action: action, for: .touchUpInside)
    view.addSubview(button)
  }
  @objc private func cancel() {
    sceneView.session.pause()
    dismiss(animated: true)
    completion?(.failure(NSError(domain: "Shelf", code: 1, userInfo: [NSLocalizedDescriptionKey: "Capture cancelled."])))
    completion = nil
  }
  @objc private func markStorage() {
    let center = CGPoint(x: sceneView.bounds.midX, y: sceneView.bounds.midY)
    guard let query = sceneView.raycastQuery(from: center, allowing: .estimatedPlane, alignment: .any),
          let result = sceneView.session.raycast(query).first else {
      status.text = "  SCAN PROGRESS                         ACTIVE\n  No surface at center\n  Point at storage and try again"; return
    }
    marks.append(["id": UUID().uuidString, "kind": "Unknown", "name": "",
      "source": "manual_ar", "width": 0.0, "height": 0.0, "depth": 0.0,
      "confidence": 1.0, "transform": matrixValues(result.worldTransform)])
    status.text = "  SCAN PROGRESS                         ACTIVE\n  \(planes.count) surfaces • \(marks.count) storage marks\n  Review names and types after finishing"
  }
  @objc private func finishScan() {
    sceneView.session.pause()
    let surfaces: [[String: Any]] = planes.values.map { plane in
      let kind: String
      if ARPlaneAnchor.isClassificationSupported {
        switch plane.classification {
        case .wall: kind = "wall"
        case .floor: kind = "floor"
        case .ceiling: kind = "ceiling"
        case .table: kind = "table"
        default: kind = "unknown"
        }
      } else {
        kind = "unknown"
      }
      return ["id": plane.identifier.uuidString, "kind": kind,
        "width": Double(plane.extent.x),
        "height": plane.alignment == .vertical ? Double(plane.extent.z) : 0.0,
        "depth": plane.alignment == .horizontal ? Double(plane.extent.z) : 0.0,
        "transform": matrixValues(plane.transform)]
    }
    let stable = detections.filter { detection in
      guard (detectionCounts[detection["id"] as? String ?? ""] ?? 0) >= 2,
            let position = detection["transform"] as? [Double], position.count == 16 else { return false }
      return !marks.contains { mark in
        guard let other = mark["transform"] as? [Double], other.count == 16 else { return false }
        let dx = position[12] - other[12]
        let dy = position[13] - other[13]
        let dz = position[14] - other[14]
        return dx * dx + dy * dy + dz * dz < 0.09
      }
    }
    completion?(.success(["backend": "arkit", "surfaces": surfaces,
      "storage": marks + stable]))
    completion = nil
    dismiss(animated: true)
  }
  func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
    DispatchQueue.main.async { for case let plane as ARPlaneAnchor in anchors { self.planes[plane.identifier] = plane } }
  }
  func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
    DispatchQueue.main.async { for case let plane as ARPlaneAnchor in anchors { self.planes[plane.identifier] = plane } }
  }
  func session(_ session: ARSession, didRemove anchors: [ARAnchor]) {
    DispatchQueue.main.async { for anchor in anchors { self.planes.removeValue(forKey: anchor.identifier) } }
  }
  func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
    DispatchQueue.main.async {
      switch camera.trackingState {
      case .normal: self.status.text = "  SCAN PROGRESS                         ACTIVE\n  \(self.planes.count) surfaces • \(self.marks.count) storage marks\n  Tracking ready"
      case .limited: self.status.text = "  SCAN PROGRESS                         LIMITED\n  \(self.planes.count) surfaces • \(self.marks.count) storage marks\n  Move slowly with better lighting"
      case .notAvailable: self.status.text = "  SCAN PROGRESS                         PAUSED\n  Tracking unavailable\n  Try another area"
      }
    }
  }
  func session(_ session: ARSession, didUpdate frame: ARFrame) {
    guard let detector, !detecting, frame.timestamp - lastDetectionTime > 0.8 else { return }
    detecting = true
    lastDetectionTime = frame.timestamp
    let request = VNCoreMLRequest(model: detector)
    request.imageCropAndScaleOption = .scaleFill
    DispatchQueue.global(qos: .userInitiated).async { [weak self] in
      defer { DispatchQueue.main.async { self?.detecting = false } }
      guard let self else { return }
      do {
        try VNImageRequestHandler(cvPixelBuffer: frame.capturedImage,
          orientation: .right, options: [:]).perform([request])
        for case let observation as VNRecognizedObjectObservation in request.results ?? [] {
          guard let label = observation.labels.first, label.confidence >= 0.55 else { continue }
          let name = label.identifier.lowercased()
          let kind: String
          if name.contains("cabinet/shelf") || name.contains("storage box") || name.contains("storage container") {
            kind = "Storage"
          }
          else if name.contains("cabinet") { kind = "Cabinet" }
          else if name.contains("shelf") { kind = "Shelf" }
          else if name.contains("drawer") { kind = "Drawer" }
          else if name.contains("rack") { kind = "Rack" }
          else { continue }
          let box = observation.boundingBox
          let point = CGPoint(x: box.midX, y: 1 - box.midY)
          let query = frame.raycastQuery(from: point, allowing: .estimatedPlane, alignment: .any)
          guard let hit = session.raycast(query).first else { continue }
          let transform = hit.worldTransform
          DispatchQueue.main.async {
            let position = transform.columns.3
            if let index = self.detections.firstIndex(where: { candidate in
              guard candidate["kind"] as? String == kind,
                    let values = candidate["transform"] as? [Double], values.count == 16 else { return false }
              let dx = values[12] - Double(position.x)
              let dy = values[13] - Double(position.y)
              let dz = values[14] - Double(position.z)
              return dx * dx + dy * dy + dz * dz < 0.09
            }) {
              let id = self.detections[index]["id"] as? String ?? ""
              self.detectionCounts[id, default: 0] += 1
              self.detections[index]["confidence"] = max(self.detections[index]["confidence"] as? Double ?? 0,
                Double(label.confidence))
            } else {
              let id = UUID().uuidString
              self.detectionCounts[id] = 1
              self.detections.append(["id": id, "kind": kind, "name": "",
                "source": "vision_coreml", "width": 0.0, "height": 0.0, "depth": 0.0,
                "confidence": Double(label.confidence), "transform": matrixValues(transform)])
            }
          }
        }
      } catch {
        DispatchQueue.main.async {
          self.status.text = "  SCAN PROGRESS                         ACTIVE\n  Storage model failed\n  Mark storage manually"
        }
      }
    }
  }
}
