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
    minimum: const EdgeInsets.fromLTRB(16, 0, 16, 12),
    child: Center(
      heightFactor: 1,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 440),
        height: 76,
        child: Row(
          children: [
            for (var index = 0; index < _items.length; index++) ...[
              if (index > 0) const SizedBox(width: 10),
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
      color: selected ? Theme.of(context).colorScheme.primary : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFF1A1A1A), width: 2),
      ),
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 25),
            const SizedBox(height: 3),
            Text(
              label,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
