// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_work_flutter/data/models/calculation_type.dart';
import 'package:open_work_flutter/data/models/work_type.dart';
import 'package:open_work_flutter/services/navigation/material_navigator.dart';
import 'package:open_work_flutter/storage/type_storage.dart';
import 'package:open_work_flutter/view/shared/input_fields/text_edit_controller.dart';

class TypeEditSheetViewModel {
  CalculationType _calculation;

  final storage = GetIt.I.get<TypeStorage>();

  final TextEditController nameEdit;
  final TextEditController priceEdit;

  final WorkType? entity;

  final String operationType;

  CalculationType get calculation => _calculation;

  TypeEditSheetViewModel(this.entity)
      : _calculation = entity?.calculation ?? CalculationType.itemsCount,
        operationType = entity?.id == null ? 'Create' : 'Edit',
        nameEdit = TextEditController.text(text: entity?.name),
        priceEdit = TextEditController.text(text: entity?.price.toString());

  Future onSave(BuildContext context) async {
    if (nameEdit.text.isEmpty) {
      nameEdit.setErrorIfEmpty();

      return;
    }

    String correct = priceEdit.text.replaceAll(RegExp(','), '.');

    double? price = double.tryParse(correct);

    if (price == null) {
      priceEdit.setError('Number can\'t be parce');

      return;
    }

    WorkType type = WorkType(
      id: entity?.id,
      name: nameEdit.text,
      price: price,
      calculation: _calculation,
    );

    await storage.updateOrCreate(type);

    if (context.mounted) {
      MaterialNavigator.pop(context);
    }
  }

  Future onDelete(BuildContext context) async {
    if (entity?.id == null) {
      return;
    }

    await storage.delete(entity!.id!);

    if (context.mounted) MaterialNavigator.pop(context);
  }

  void setCalculation(CalculationType value) => _calculation = value;
}
