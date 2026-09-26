import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:final_project/data/app_database.dart';
import 'package:final_project/data/inventory_repository.dart';
import 'package:final_project/models/shelf_models.dart';
import 'package:final_project/screens/inventory_screens.dart';
import 'package:final_project/state/providers.dart';

void main() {
  testWidgets('checkout form and return screen update the same loan', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final repository = InventoryRepository(database);
    final workspace = await repository.saveWorkspace('Media Room', '');
    const container = ShelfContainer(
      id: 'cabinet',
      name: 'Equipment Cabinet',
      type: 'Cabinet',
    );
    await repository.saveContainer(container, workspace);
    await repository.saveLayout(container, 'One section', ['Top Shelf']);
    final section = (await repository.load()).sections.single.id;
    await repository.addCandidate(sectionId: section, name: 'Camera Lens');
    await repository.confirmCandidates(section, workspace);
    final itemId = (await repository.load()).items.single.id;
    Future<void> showLoan({required bool returning}) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [databaseProvider.overrideWithValue(database)],
          child: MaterialApp(
            home: LoanActionScreen(itemId: itemId, returning: returning),
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    await showLoan(returning: false);
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Borrower *'),
      'Vince',
    );
    await tester.ensureVisible(find.text('EXPECTED RETURN *'));
    await tester.tap(find.text('EXPECTED RETURN *'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('CONFIRM CHECKOUT'));
    await tester.tap(find.text('CONFIRM CHECKOUT'));
    await tester.pumpAndSettle();
    var state = await repository.load();
    expect(state.items.single.status, ItemStatus.checkedOut);
    expect(state.loans.single.borrower, 'Vince');
    await tester.pumpWidget(const SizedBox());
    await showLoan(returning: true);
    await tester.ensureVisible(find.text('CONFIRM RETURN'));
    await tester.tap(find.text('CONFIRM RETURN'));
    await tester.pumpAndSettle();
    state = await repository.load();
    expect(state.items.single.status, ItemStatus.available);
    expect(state.loans.single.returnedAt, isNotNull);
  });
}
