import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../models/shelf_models.dart';
import 'shelf_stored_image.dart';

class ShelfRoomPhoto extends StatefulWidget {
  const ShelfRoomPhoto({
    super.key,
    required this.photoPath,
    required this.markers,
    this.onPhotoTap,
    this.onMarkerTap,
    this.height = 420,
  });
  final String photoPath;
  final List<ShelfContainer> markers;
  final void Function(double x, double y)? onPhotoTap;
  final ValueChanged<ShelfContainer>? onMarkerTap;
  final double height;

  @override
  State<ShelfRoomPhoto> createState() => _ShelfRoomPhotoState();
}

class _ShelfRoomPhotoState extends State<ShelfRoomPhoto> {
  late Future<(File, Size)?> _photo;

  @override
  void initState() {
    super.initState();
    _photo = _loadPhoto();
  }

  @override
  void didUpdateWidget(covariant ShelfRoomPhoto oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.photoPath != widget.photoPath) _photo = _loadPhoto();
  }

  Future<(File, Size)?> _loadPhoto() async {
    final file = await shelfMediaFile(widget.photoPath);
    if (file == null) return null;
    final codec = await ui.instantiateImageCodec(await file.readAsBytes());
    final frame = await codec.getNextFrame();
    final size = Size(
      frame.image.width.toDouble(),
      frame.image.height.toDouble(),
    );
    frame.image.dispose();
    codec.dispose();
    return (file, size);
  }

  @override
  Widget build(BuildContext context) => Container(
    height: widget.height,
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.secondary,
      border: Border.all(width: 3),
      borderRadius: BorderRadius.circular(8),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: LayoutBuilder(
        builder: (context, constraints) => FutureBuilder<(File, Size)?>(
          future: _photo,
          builder: (context, snapshot) {
            final photo = snapshot.data;
            if (photo == null) {
              return const Center(child: Text('Room view unavailable'));
            }
            final scale = math.min(
              constraints.maxWidth / photo.$2.width,
              constraints.maxHeight / photo.$2.height,
            );
            final width = photo.$2.width * scale;
            final height = photo.$2.height * scale;
            final left = (constraints.maxWidth - width) / 2;
            final top = (constraints.maxHeight - height) / 2;
            return Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  left: left,
                  top: top,
                  width: width,
                  height: height,
                  child: GestureDetector(
                    onTapUp: widget.onPhotoTap == null
                        ? null
                        : (details) => widget.onPhotoTap!(
                            (details.localPosition.dx / width).clamp(0.0, 1.0),
                            (details.localPosition.dy / height).clamp(0.0, 1.0),
                          ),
                    child: Image.file(photo.$1, fit: BoxFit.fill),
                  ),
                ),
                for (final marker in widget.markers)
                  if (marker.markerPhotoPath == widget.photoPath &&
                      marker.markerX != null &&
                      marker.markerY != null)
                    Positioned(
                      left:
                          left +
                          (marker.markerX! * width - 18).clamp(0.0, width - 36),
                      top:
                          top +
                          (marker.markerY! * height - 18).clamp(
                            0.0,
                            height - 36,
                          ),
                      child: Semantics(
                        button: true,
                        label: 'Open ${marker.name}',
                        child: Material(
                          color: Theme.of(context).colorScheme.primary,
                          shape: const CircleBorder(
                            side: BorderSide(color: Colors.black, width: 2),
                          ),
                          child: InkWell(
                            onTap: widget.onMarkerTap == null
                                ? null
                                : () => widget.onMarkerTap!(marker),
                            customBorder: const CircleBorder(),
                            child: const SizedBox(
                              width: 36,
                              height: 36,
                              child: Icon(Icons.place, size: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
              ],
            );
          },
        ),
      ),
    ),
  );
}
