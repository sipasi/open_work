import 'package:flutter/material.dart';
import 'package:open_work_flutter/view/shared/input_fields/text_edit_controller.dart';

class TextEditField extends StatelessWidget {
  final TextEditController controller;

  final void Function(String value)? onChanged;
  final void Function(String value)? onSubmit;
  final void Function()? onEditingComplete;

  final String? label;
  final String? hint;

  final InputBorder? border;

  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int? maxLines;

  const TextEditField({
    super.key,
    required this.controller,
    this.onChanged,
    this.onSubmit,
    this.onEditingComplete,
    this.label,
    this.hint,
    this.border,
    this.keyboardType,
    this.textInputAction,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller.controller,
      focusNode: controller.focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      maxLines: maxLines,
      onChanged: onChanged,
      onSubmitted: onSubmit,
      onEditingComplete: onEditingComplete,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        errorText: controller.error,
        border: border,
      ),
    );
  }
}
