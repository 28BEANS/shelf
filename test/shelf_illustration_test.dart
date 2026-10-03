import 'package:final_project/widgets/shelf_illustration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('login artwork follows a drag and returns to rest', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(child: SizedBox(width: 320, child: ShelfIllustration())),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final artwork = find.descendant(
      of: find.byType(ShelfIllustration),
      matching: find.byType(Image),
    );
    final restingCenter = tester.getCenter(artwork);
    final bounds = tester.getRect(find.byType(ShelfIllustration));
    final gesture = await tester.startGesture(
      Offset(bounds.left + 24, bounds.center.dy),
    );
    await tester.pump();
    await gesture.moveTo(Offset(bounds.right - 24, bounds.center.dy));
    await tester.pump();

    expect(
      (tester.getCenter(artwork) - restingCenter).dx,
      greaterThan(8),
    );

    await gesture.up();
    await tester.pumpAndSettle();
    expect((tester.getCenter(artwork) - restingCenter).distance, lessThan(1));
  });
}
