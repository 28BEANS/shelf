import 'package:flutter/material.dart';

class ShelfTextField extends StatelessWidget {
  const ShelfTextField({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
    this.onChanged,
    this.hintText,
    this.maxLines = 1,
  });
  final String label;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final String? hintText;
  final int maxLines;

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    validator: validator,
    onChanged: onChanged,
    maxLines: maxLines,
    textInputAction: maxLines == 1
        ? TextInputAction.next
        : TextInputAction.newline,
    decoration: InputDecoration(labelText: label, hintText: hintText),
  );
}
