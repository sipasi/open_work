import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_work_flutter/data/models/work_type.dart';
import 'package:open_work_flutter/services/navigation/material_navigator.dart';
import 'package:open_work_flutter/services/result.dart';
import 'package:open_work_flutter/theme/theme_extension.dart';
import 'package:open_work_flutter/view/shared/input_fields/price_edit_field.dart';
import 'package:open_work_flutter/view/shared/input_fields/text_edit_controller.dart';
import 'package:open_work_flutter/view/shared/input_fields/text_edit_field.dart';

import 'calculation_type_dropdown.dart';
import 'type_edit_sheet_view_model.dart';

class TypeEditSheet extends StatefulWidget {
  final WorkType? entity;

  const TypeEditSheet({super.key, this.entity});

  static Future<Result> create(BuildContext context) async {
    return _show(context);
  }

  static Future<Result> edit(BuildContext context, WorkType entity) async {
    return _show(context, entity);
  }

  static Future<Result> _show(BuildContext context, [WorkType? entity]) async {
    final result = await showModalBottomSheet<Result>(
      context: context,
      isScrollControlled: true,
      builder: (builder) => TypeEditSheet(entity: entity),
    );

    return result ?? Result.empty();
  }

  @override
  State<TypeEditSheet> createState() => _TypeEditSheetState();
}

class _TypeEditSheetState extends State<TypeEditSheet> {
  late final TypeEditSheetViewModel _viewmodel;

  late final TextEditController _nameEdit;
  late final TextEditController _priceEdit;

  late final String _operationType;

  @override
  void initState() {
    super.initState();

    final entity = widget.entity;

    _operationType = entity?.id == null ? 'Create' : 'Edit';

    _viewmodel = TypeEditSheetViewModel(
      typeStorage: GetIt.I.get(),
      entity: entity,
    );

    _nameEdit = TextEditController.text(text: _viewmodel.name);
    _priceEdit = TextEditController.text(text: _viewmodel.price);
  }

  @override
  Widget build(BuildContext context) {
    final operationTypeStyle = context.textTheme.headlineMedium?.copyWith(
      color: context.colorScheme.primary,
      fontWeight: FontWeight.bold,
    );

    return Padding(
      padding: const EdgeInsets.all(20).copyWith(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _operationType,
            textAlign: TextAlign.center,
            style: operationTypeStyle,
          ),
          const SizedBox(height: 10),
          TextEditField(
            label: 'name',
            controller: _nameEdit,
            border: const OutlineInputBorder(),
            keyboardType: TextInputType.text,
            onChanged: (value) => setState(() {
              _viewmodel.setName(value);
              _nameEdit.setErrorIfEmpty();
            }),
          ),
          const SizedBox(height: 10),
          PriceEditField(
            label: 'price',
            controller: _priceEdit,
            border: const OutlineInputBorder(),
            onChanged: (value) => setState(() {
              _viewmodel.setPrice(value);
              _priceEdit.setErrorIfEmpty();
            }),
          ),
          const SizedBox(height: 10),
          CalculationTypeDropdown(
            initialSelection: _viewmodel.calculation,
            onSelected: (calculation) => setState(
              () => _viewmodel.setCalculation(calculation),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (widget.entity != null)
                FilledButton.tonalIcon(
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete'),
                  onPressed: () async {
                    await _viewmodel.tryDelete();

                    if (context.mounted) {
                      MaterialNavigator.pop(context);
                    }
                  },
                ),
              if (widget.entity != null) const SizedBox(width: 20),
              FilledButton.tonalIcon(
                icon: const Icon(Icons.save),
                label: const Text('Save'),
                onPressed: () async {
                  bool saved = await _viewmodel.trySubmit();

                  if (saved && context.mounted) {
                    MaterialNavigator.pop(context);
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
