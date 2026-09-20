import 'package:flutter/material.dart';

class PrimaryActionButton extends StatelessWidget {
  const PrimaryActionButton({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
  });
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(999),
      boxShadow: const [
        BoxShadow(color: Colors.white, offset: Offset(5, 6), blurRadius: 0),
      ],
    ),
    child: icon == null
        ? FilledButton(onPressed: onPressed, child: Text(label.toUpperCase()))
        : FilledButton.icon(
            onPressed: onPressed,
            icon: Icon(icon),
            label: Text(label.toUpperCase()),
          ),
  );
}
