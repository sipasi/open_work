// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:open_work_flutter/data/models/work_type.dart';
import 'package:open_work_flutter/services/result.dart';
import 'package:open_work_flutter/view/shared/input_fields/text_edit_field.dart';

import 'calculation_type_dropdown.dart';
import 'type_edit_sheet_view_model.dart';

class TypeEditSheet extends StatefulWidget {
  final WorkType? entity;

  const TypeEditSheet({super.key, this.entity});

  static Future<Result> show(BuildContext context, [WorkType? entity]) async {
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

  @override
  void initState() {
    super.initState();

    _viewmodel = TypeEditSheetViewModel(widget.entity);
  }

  @override
  Widget build(BuildContext context) {
    final operationTypeStyle =
        Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
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
            _viewmodel.operationType,
            textAlign: TextAlign.center,
            style: operationTypeStyle,
          ),
          const SizedBox(height: 10),
          TextEditField(
            controller: _viewmodel.nameEdit,
            label: 'name',
            keyboardType: TextInputType.text,
            border: const OutlineInputBorder(),
          ),
          const SizedBox(height: 10),
          TextEditField(
            controller: _viewmodel.priceEdit,
            label: 'price',
            keyboardType: const TextInputType.numberWithOptions(
              signed: false,
              decimal: true,
            ),
            border: const OutlineInputBorder(),
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
              widget.entity != null
                  ? FilledButton.tonalIcon(
                      icon: const Icon(Icons.delete),
                      label: const Text('Delete'),
                      onPressed: () => _viewmodel.onDelete(context),
                    )
                  : Container(),
              const SizedBox(width: 20),
              FilledButton.tonalIcon(
                icon: const Icon(Icons.save),
                label: const Text('Save'),
                onPressed: () => _viewmodel.onSave(context),
              ),
            ],
          )
        ],
      ),
    );
  }
}
