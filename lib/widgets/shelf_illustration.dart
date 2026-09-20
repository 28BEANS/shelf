import 'package:flutter/material.dart';

class ShelfIllustration extends StatelessWidget {
  const ShelfIllustration({super.key, this.height = 132});
  final double height;

  @override
  Widget build(BuildContext context) => Container(
    height: height,
    padding: const EdgeInsets.symmetric(horizontal: 68, vertical: 20),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.secondary,
      border: Border.all(width: 3),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 2),
      ),
      child: Column(
        children: [
          _shelfRow(context, true),
          _shelfRow(context, false),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(width: 2),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  Widget _shelfRow(BuildContext context, bool reverse) => Expanded(
    child: Container(
      padding: const EdgeInsets.all(6),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(width: 2)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _item(
              reverse
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.tertiary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _item(
              reverse
                  ? Theme.of(context).colorScheme.tertiary
                  : Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    ),
  );

  Widget _item(Color color) => Container(
    decoration: BoxDecoration(
      color: color,
      border: Border.all(width: 2),
      borderRadius: BorderRadius.circular(3),
    ),
  );
}
