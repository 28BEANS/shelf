import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';

import 'package:final_project/app.dart';
import 'package:final_project/data/app_database.dart';
import 'package:final_project/state/providers.dart';

void main() {
  late AppDatabase database;
  setUp(() => database = AppDatabase(NativeDatabase.memory()));
  tearDown(() => database.close());

  testWidgets('local sign-in opens the spaces screen', (tester) async {
    _phoneViewport(tester);
    await _pumpApp(tester, database);

    expect(find.text('Know where\neverything belongs.'), findsOneWidget);
    await _signIn(tester);

    expect(find.text('Your Spaces'), findsOneWidget);
    expect(find.text('No spaces yet'), findsOneWidget);
  });

  testWidgets('local sign-in requires both fields', (tester) async {
    _phoneViewport(tester);
    await _pumpApp(tester, database);
    await tester.drag(find.byType(ListView).first, const Offset(0, -400));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('enter-shelf')));
    await tester.pump();

    expect(find.text('Required'), findsNWidgets(2));
  });

  testWidgets('sample room setup reaches the mockup section screen', (
    tester,
  ) async {
    _phoneViewport(tester);
    await _pumpApp(tester, database);
    await _signIn(tester);

    await tester.tap(find.byKey(const Key('start-setup')));
    await tester.pumpAndSettle();
    expect(find.text('Add inventory'), findsOneWidget);
    await tester.tap(find.byKey(const Key('scan-workspace')));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Workspace name'),
      'Campus Media Room',
    );
    await tester.tap(find.text('CREATE'));
    await tester.pumpAndSettle();
    expect(find.text('Scanning workspace'), findsOneWidget);

    await tester.drag(find.byType(ListView).last, const Offset(0, -420));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('finish-room-scan')));
    await tester.pumpAndSettle();
    expect(find.text('Room captured'), findsOneWidget);

    await tester.ensureVisible(find.byKey(const Key('continue-detected')));
    await tester.tap(find.byKey(const Key('continue-detected')));
    await tester.pumpAndSettle();
    expect(find.text('Choose a layout'), findsOneWidget);

    await tester.ensureVisible(find.byKey(const Key('use-layout')));
    await tester.tap(find.byKey(const Key('use-layout')));
    await tester.pumpAndSettle();
    expect(find.text('Select a section'), findsOneWidget);
    expect(find.text('Bottom Shelf'), findsAtLeastNWidgets(1));
  });
}

Future<void> _pumpApp(WidgetTester tester, AppDatabase database) =>
    tester.pumpWidget(
      ProviderScope(
        overrides: [databaseProvider.overrideWithValue(database)],
        child: const ShelfApp(),
      ),
    );

void _phoneViewport(WidgetTester tester) {
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

Future<void> _signIn(WidgetTester tester) async {
  await tester.enterText(
    find.widgetWithText(TextFormField, 'Email'),
    'demo@shelf.local',
  );
  await tester.enterText(
    find.widgetWithText(TextFormField, 'Password'),
    'password',
  );
  await tester.drag(find.byType(ListView).first, const Offset(0, -400));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const Key('enter-shelf')));
  await tester.pumpAndSettle();
}
