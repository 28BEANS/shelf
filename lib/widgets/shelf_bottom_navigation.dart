import 'package:flutter/material.dart';

class ShelfBottomNavigation extends StatelessWidget {
  const ShelfBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onDestinationSelected,
  });
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  static const _items = [
    (Icons.home_outlined, Icons.home, 'Home'),
    (Icons.center_focus_weak, Icons.center_focus_strong, 'Scan'),
    (Icons.search, Icons.search, 'Search'),
  ];

  @override
  Widget build(BuildContext context) => SafeArea(
    minimum: const EdgeInsets.fromLTRB(14, 0, 14, 12),
    child: Center(
      heightFactor: 1,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 360),
        height: 74,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          border: Border.all(width: 3),
          borderRadius: BorderRadius.circular(9),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFF1A1A1A),
              offset: Offset(5, 6),
              blurRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            for (var index = 0; index < _items.length; index++)
              Expanded(
                child: _NavigationItem(
                  icon: currentIndex == index
                      ? _items[index].$2
                      : _items[index].$1,
                  label: _items[index].$3,
                  selected: currentIndex == index,
                  onTap: () => onDestinationSelected(index),
                ),
              ),
          ],
        ),
      ),
    ),
  );
}

class _NavigationItem extends StatelessWidget {
  const _NavigationItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    selected: selected,
    button: true,
    label: label,
    child: Material(
      color: selected
          ? Theme.of(context).colorScheme.primary
          : const Color(0xFFF5F0EF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: selected ? const BorderSide(width: 2) : BorderSide.none,
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28),
            const SizedBox(height: 2),
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    ),
  );
}
