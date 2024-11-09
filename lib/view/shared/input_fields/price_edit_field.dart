import 'package:flutter/material.dart';
import 'package:open_work_flutter/view/shared/input_fields/text_edit_controller.dart';
import 'package:open_work_flutter/view/shared/input_fields/text_edit_field.dart';
import 'package:open_work_flutter/view/shared/input_fields/text_formatter.dart';

class PriceEditField extends StatelessWidget {
  final TextEditController controller;

  final String? label;
  final String? hint;

  final TextStyle? style;

  final InputBorder? border;

  final void Function(String value)? onChanged;

  const PriceEditField({
    super.key,
    required this.controller,
    this.label,
    this.hint,
    this.style,
    this.border,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextEditField(
      controller: controller,
      label: label,
      hint: label,
      style: style,
      border: border,
      keyboardType: const TextInputType.numberWithOptions(
        signed: false,
        decimal: true,
      ),
      inputFormatters: [
        TextFormatter.decimalFormatter,
      ],
      onChanged: onChanged,
    );
  }
}
