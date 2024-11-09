import 'package:flutter/material.dart';
import 'package:open_work_flutter/view/shared/input_fields/text_edit_controller.dart';
import 'package:open_work_flutter/view/shared/input_fields/text_edit_field.dart';
import 'package:open_work_flutter/view/shared/input_fields/text_formatter.dart';

class PriceEditField extends StatelessWidget {
  final TextEditController controller;

  final void Function(String value)? onChanged;

  final String? label;
  final String? hint;

  final InputBorder? border;

  const PriceEditField({
    super.key,
    required this.controller,
    this.onChanged,
    this.label,
    this.hint,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return TextEditField(
      label: label,
      hint: label,
      controller: controller,
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
