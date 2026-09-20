import 'package:flutter/material.dart';

import '../theme.dart';

class ShelfLogoMark extends StatelessWidget {
  const ShelfLogoMark({super.key, this.compact = false});
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final width = compact ? 38.0 : 52.0;
    final height = compact ? 8.0 : 11.0;
    return Semantics(
      label: 'Shelf logo',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _bar(width, height, Theme.of(context).colorScheme.primary),
          const SizedBox(height: 3),
          _bar(width, height, Theme.of(context).colorScheme.secondary),
          const SizedBox(height: 3),
          _bar(width, height, Theme.of(context).colorScheme.tertiary),
        ],
      ),
    );
  }

  Widget _bar(double width, double height, Color color) => Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: color,
      border: Border.all(color: const Color(0xFF1A1A1A), width: 1),
      borderRadius: BorderRadius.circular(4),
    ),
  );
}

class ShelfLocatorRail extends StatelessWidget {
  const ShelfLocatorRail({super.key});

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      _node(Theme.of(context).colorScheme.primary),
      const SizedBox(height: 5),
      _node(Theme.of(context).colorScheme.secondary),
      const SizedBox(height: 5),
      _node(Theme.of(context).colorScheme.tertiary),
    ],
  );

  Widget _node(Color color) => Container(
    width: 9,
    height: 16,
    decoration: BoxDecoration(
      color: color,
      border: Border.all(width: 2),
      borderRadius: BorderRadius.circular(1),
    ),
  );
}

class ShelfPageHeader extends StatelessWidget {
  const ShelfPageHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    this.showLogo = true,
  });
  final String eyebrow;
  final String title;
  final String subtitle;
  final bool showLogo;

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (showLogo) ...[
        const Padding(
          padding: EdgeInsets.only(top: 14),
          child: ShelfLogoMark(compact: true),
        ),
        const SizedBox(width: AppSpacing.listItem),
      ],
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              eyebrow.toUpperCase(),
              style: Theme.of(
                context,
              ).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w800),
            ),
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
            Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
      const ShelfLocatorRail(),
    ],
  );
}

class ShelfMobileRail extends StatelessWidget {
  const ShelfMobileRail({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.topCenter,
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 390),
      child: child,
    ),
  );
}
