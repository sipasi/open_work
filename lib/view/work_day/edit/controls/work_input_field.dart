import 'package:flutter/material.dart';
import 'package:open_work_flutter/data/models/calculation_type.dart';
import 'package:open_work_flutter/view/shared/input_fields/text_edit_controller.dart';
import 'package:open_work_flutter/view/shared/input_fields/text_edit_field.dart';
import 'package:open_work_flutter/view/work_day/edit/controls/work_input_validator.dart';

class WorkInputField extends StatefulWidget {
  final CalculationType calculation;
  final WorkInputValidator validator;

  final TextEditController controller;

  final void Function(String value) onSubmit;

  const WorkInputField({
    super.key,
    required this.calculation,
    required this.validator,
    required this.controller,
    required this.onSubmit,
  });

  @override
  State<WorkInputField> createState() => _WorkInputFieldState();
}

class _WorkInputFieldState extends State<WorkInputField> {
  @override
  Widget build(BuildContext context) {
    final keyboardType = switch (widget.calculation) {
      CalculationType.numbersSum => const TextInputType.numberWithOptions(
          signed: false,
          decimal: true,
        ),
      CalculationType.itemsCount => TextInputType.text
    };

    return TextEditField(
      controller: widget.controller,
      textInputAction: TextInputAction.done,
      keyboardType: keyboardType,
      onChanged: _onChanged,
      onSubmit: (value) => _onSubmit(),
      onEditingComplete: () {},
    );
  }

  void _onChanged(String value) => _validateInput(value.trim());

  void _onSubmit() {
    final value = widget.controller.textTrim;

    if (_validateInput(value) == false) return;

    setState(() {
      widget.controller.clear();
    });

    widget.onSubmit(value);
  }

  bool _validateInput(String input) {
    final (bool error, String? message) = widget.validator.validate(
      input,
      widget.calculation,
    );

    setState(() {
      error
          ? widget.controller.setError(message!)
          : widget.controller.clearError();
    });

    return error == false;
  }
}
