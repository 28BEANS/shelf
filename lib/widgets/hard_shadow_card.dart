import 'package:flutter/material.dart';

class HardShadowCard extends StatelessWidget {
  const HardShadowCard({
    super.key,
    required this.child,
    this.color = Colors.white,
    this.padding = const EdgeInsets.all(12),
    this.dashed = false,
    this.onTap,
  });
  final Widget child;
  final Color color;
  final EdgeInsetsGeometry padding;
  final bool dashed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final content = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: const Color(0xFF1A1A1A),
          width: dashed ? 2 : 3,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: dashed
            ? null
            : const [
                BoxShadow(
                  color: Color(0xFF1A1A1A),
                  offset: Offset(6, 7),
                  blurRadius: 0,
                ),
              ],
      ),
      child: child,
    );
    if (onTap == null) {
      return Padding(
        padding: const EdgeInsets.only(right: 6, bottom: 7),
        child: content,
      );
    }
    return Padding(
      padding: const EdgeInsets.only(right: 6, bottom: 7),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: content,
        ),
      ),
    );
  }
}
