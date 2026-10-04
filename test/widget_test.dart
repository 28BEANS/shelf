import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';

import 'package:final_project/app.dart';
import 'package:final_project/data/app_database.dart';
import 'package:final_project/data/inventory_repository.dart';
import 'package:final_project/models/shelf_models.dart';
import 'package:final_project/state/providers.dart';
import 'package:final_project/services/scan_service.dart';
import 'package:final_project/services/shelf_auth.dart';
import 'package:final_project/widgets/shelf_loading_animation.dart';

void main() {
  late AppDatabase database;
  setUp(() => database = AppDatabase(NativeDatabase.memory()));
  tearDown(() => database.close());

  testWidgets('startup shows the Shelf animation before login', (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [databaseProvider.overrideWithValue(database)],
        child: ShelfApp(authGateway: _TestAuth()),
      ),
    );
    expect(find.byType(ShelfLoadingAnimation), findsOneWidget);
    expect(find.text('OPENING YOUR SHELF'), findsOneWidget);
    expect(find.byKey(const Key('passcode')), findsNothing);

    await tester.pump(const Duration(milliseconds: 2300));
    await tester.pumpAndSettle();
    expect(find.byType(ShelfLoadingAnimation), findsNothing);
    expect(find.byKey(const Key('passcode')), findsOneWidget);
  });

  testWidgets('passcode opens the spaces screen', (tester) async {
    _phoneViewport(tester);
    await _pumpApp(tester, database);

    expect(find.text('Know where\neverything belongs.'), findsOneWidget);
    await _signIn(tester);

    expect(find.text('Your Spaces'), findsOneWidget);
    expect(find.text('No spaces yet'), findsOneWidget);
    expect(find.byKey(const Key('restart-sign-in-demo')), findsNothing);
  });

  testWidgets('login requires six digits', (tester) async {
    _phoneViewport(tester);
    await _pumpApp(tester, database);
    await tester.drag(find.byType(ListView).first, const Offset(0, -400));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('enter-shelf')));
    await tester.pump();

    expect(find.text('Enter exactly six digits.'), findsOneWidget);
  });

  testWidgets('logout returns to passcode login', (tester) async {
    _phoneViewport(tester);
    await _pumpApp(tester, database);
    await _signIn(tester);
    await tester.tap(find.byKey(const Key('logout')));
    await tester.pumpAndSettle();

    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.byKey(const Key('passcode')), findsOneWidget);
    expect(find.text('Your Spaces'), findsNothing);
  });

  testWidgets('demo reset replays Google and keeps local workspace', (
    tester,
  ) async {
    _phoneViewport(tester);
    final repository = InventoryRepository(database);
    final workspaceId = await repository.saveWorkspace('Presentation Room', '');
    await repository.saveContainer(
      const ShelfContainer(
        id: 'demo-cabinet',
        name: 'Demo Cabinet',
        type: 'Cabinet',
      ),
      workspaceId,
    );
    final auth = _TestAuth();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [databaseProvider.overrideWithValue(database)],
        child: ShelfApp(authGateway: auth, enableDemoReset: true),
      ),
    );
    await tester.pump(const Duration(milliseconds: 2300));
    await tester.pumpAndSettle();
    await _signIn(tester);
    expect(find.text('Presentation Room'), findsOneWidget);

    await tester.tap(find.byKey(const Key('restart-sign-in-demo')));
    await tester.pumpAndSettle();
    expect(find.text('Replay Google sign-in?'), findsOneWidget);
    await tester.tap(find.text('CANCEL'));
    await tester.pumpAndSettle();
    expect(auth.demoResets, 0);

    await tester.tap(find.byKey(const Key('restart-sign-in-demo')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('confirm-demo-reset')));
    await tester.pumpAndSettle();
    expect(auth.demoResets, 1);
    expect(find.text('Create your account'), findsOneWidget);
    expect(find.text('Presentation Room'), findsNothing);

    await tester.ensureVisible(find.byKey(const Key('enter-shelf')));
    await tester.tap(find.byKey(const Key('enter-shelf')));
    await tester.pumpAndSettle();
    expect(find.text('Secure this device'), findsOneWidget);
    await tester.enterText(find.byKey(const Key('passcode')), '123456');
    await tester.enterText(find.byKey(const Key('confirm-passcode')), '123456');
    await tester.drag(find.byType(ListView).first, const Offset(0, -400));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const Key('enter-shelf')));
    await tester.tap(find.byKey(const Key('enter-shelf')));
    await tester.pumpAndSettle();
    expect(find.text('Welcome back'), findsOneWidget);
    await _signIn(tester);
    expect(find.text('Presentation Room'), findsOneWidget);
    expect((await repository.load()).workspace?.name, 'Presentation Room');
  });

  testWidgets('Google registration saves PIN then returns to login', (
    tester,
  ) async {
    _phoneViewport(tester);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [databaseProvider.overrideWithValue(database)],
        child: ShelfApp(
          authGateway: _TestAuth(initial: ShelfAuthStep.register),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 2300));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const Key('enter-shelf')));
    await tester.tap(find.byKey(const Key('enter-shelf')));
    await tester.pumpAndSettle();
    expect(find.text('Secure this device'), findsOneWidget);
    await tester.enterText(find.byKey(const Key('passcode')), '123456');
    await tester.enterText(find.byKey(const Key('confirm-passcode')), '123456');
    await tester.drag(find.byType(ListView).first, const Offset(0, -400));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const Key('enter-shelf')));
    await tester.tap(find.byKey(const Key('enter-shelf')));
    await tester.pumpAndSettle();
    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.text('Your Spaces'), findsNothing);
  });

  testWidgets('manual room setup reaches the mockup section screen', (
    tester,
  ) async {
    _phoneViewport(tester);
    await _pumpApp(tester, database);
    await _signIn(tester);

    await tester.tap(find.byKey(const Key('start-setup')));
    await tester.pumpAndSettle();
    expect(find.text('Add inventory'), findsOneWidget);
    await tester.tap(find.text('SET UP MANUALLY →'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Workspace name'),
      'Campus Media Room',
    );
    await tester.tap(find.text('CREATE'));
    await tester.pumpAndSettle();
    expect(find.text('Storage space'), findsOneWidget);

    await tester.tap(find.byKey(const Key('continue-detected')));
    await tester.pumpAndSettle();
    expect(find.text('Choose a layout'), findsOneWidget);

    await tester.ensureVisible(find.byKey(const Key('use-layout')));
    await tester.tap(find.byKey(const Key('use-layout')));
    await tester.pumpAndSettle();
    expect(find.text('Select a section'), findsOneWidget);
    expect(find.text('Bottom Shelf'), findsAtLeastNWidgets(1));
  });

  testWidgets('room review saves only confirmed storage', (tester) async {
    _phoneViewport(tester);
    await _pumpApp(tester, database, scanService: const _TestScanService());
    await _signIn(tester);
    await tester.tap(find.byKey(const Key('start-setup')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('scan-workspace')));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Workspace name'),
      'Media Room',
    );
    await tester.tap(find.text('CREATE'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const Key('finish-room-scan')));
    await tester.tap(find.byKey(const Key('finish-room-scan')));
    await tester.pumpAndSettle();
    expect(await database.select(database.roomScans).get(), isEmpty);
    expect(find.text('Room captured'), findsOneWidget);
    await tester.drag(
      find.byKey(const ValueKey('detected-spaces')),
      const Offset(0, -420),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('CONFIRM').first);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('continue-detected')));
    await tester.pumpAndSettle();
    expect(find.text('Choose a layout'), findsOneWidget);
    expect(await database.select(database.roomScans).get(), hasLength(1));
    expect(
      await database.select(database.storageContainers).get(),
      hasLength(1),
    );
  });

  testWidgets('search shows the current location after an item moves', (
    tester,
  ) async {
    _phoneViewport(tester);
    final repository = InventoryRepository(database);
    final workspaceId = await repository.saveWorkspace('Media Room', '');
    const container = ShelfContainer(
      id: 'cabinet',
      name: 'Cabinet',
      type: 'Cabinet',
    );
    await repository.saveContainer(container, workspaceId);
    await repository.saveLayout(container, 'Two sections', [
      'Section 1',
      'Section 2',
    ]);
    final sections = (await repository.load()).sections;
    await repository.addCandidate(sectionId: sections[0].id, name: 'Camera');
    await repository.confirmCandidates(sections[0].id, workspaceId);
    final item = (await repository.load()).items.single;
    await repository.moveItem(item.id, sections[1].id);

    await _pumpApp(tester, database);
    await _signIn(tester);
    await tester.tap(find.text('Search').last);
    await tester.pumpAndSettle();

    expect(find.text('CURRENT LOCATION'), findsOneWidget);
    expect(find.text('Cabinet → Section 2'), findsOneWidget);
    expect(find.text('ORIGINAL HOME'), findsOneWidget);
    expect(find.text('Cabinet → Section 1'), findsOneWidget);
  });
}

Future<void> _pumpApp(
  WidgetTester tester,
  AppDatabase database, {
  ScanService? scanService,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(database),
        if (scanService != null)
          scanServiceProvider.overrideWithValue(scanService),
      ],
      child: ShelfApp(authGateway: _TestAuth()),
    ),
  );
  await tester.pump(const Duration(milliseconds: 2300));
  await tester.pumpAndSettle();
}

void _phoneViewport(WidgetTester tester) {
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

class _TestScanService implements ScanService {
  const _TestScanService();
  @override
  Future<ScanCapabilities> capabilities() async => const ScanCapabilities(
    roomBackend: 'arkit',
    itemCamera: true,
    semanticStorage: false,
  );
  @override
  Future<void> cancel() async {}
  @override
  Future<ItemCaptureResult> scanItems() async =>
      const ItemCaptureResult(photoPath: '', suggestions: []);
  @override
  Future<ShelfRoom> scanRoom() async {
    const transform = <double>[1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1];
    return const ShelfRoom(
      backend: 'arkit',
      surfaces: [
        ShelfSurface(
          id: 'wall',
          kind: 'wall',
          width: 3,
          height: 2,
          transform: transform,
        ),
      ],
      storage: [
        ShelfStorageUnit(
          id: 'one',
          kind: 'Cabinet',
          source: 'manual_ar',
          width: 0,
          height: 0,
          depth: 0,
          confidence: 1,
          transform: transform,
        ),
        ShelfStorageUnit(
          id: 'two',
          kind: 'Shelf',
          source: 'manual_ar',
          width: 0,
          height: 0,
          depth: 0,
          confidence: 1,
          transform: transform,
        ),
      ],
    );
  }
}

Future<void> _signIn(WidgetTester tester) async {
  await tester.pump();
  await tester.enterText(find.byKey(const Key('passcode')), '123456');
  await tester.drag(find.byType(ListView).first, const Offset(0, -400));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const Key('enter-shelf')));
  await tester.pumpAndSettle();
}

class _TestAuth implements ShelfAuthGateway {
  _TestAuth({this.initial = ShelfAuthStep.login});
  final ShelfAuthStep initial;
  int demoResets = 0;
  @override
  Future<ShelfAuthStep> initialStep() async => initial;
  @override
  Future<ShelfAuthStep> continueWithGoogle() async =>
      ShelfAuthStep.createPasscode;
  @override
  Future<void> createPasscode(String passcode) async {}
  @override
  Future<bool> unlock(String passcode) async => passcode == '123456';
  @override
  Future<void> logout() async {}
  @override
  Future<void> restartSignInDemo() async {
    demoResets++;
  }
}
