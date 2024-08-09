import 'package:flutter/material.dart';
import 'package:open_work_flutter/data/models/work_type.dart';
import 'package:open_work_flutter/storage/type_storage.dart';
import 'package:open_work_flutter/view/work_type/edit/type_edit_sheet.dart';

class WorkTypeListViewModel {
  final TypeStorage storage;

  final List<WorkType> types;

  WorkTypeListViewModel(this.storage) : types = [];

  Future onTap(BuildContext context, int index) async {
    final type = types[index];

    await TypeEditSheet.show(context, type);

    await loadAll();
  }

  Future onAdd(BuildContext context) async {
    await TypeEditSheet.show(context);

    await loadAll();
  }

  void refill(List<WorkType> items) => types
    ..clear()
    ..addAll(items);

  Future loadAll() async {
    refill(await storage.getAll());
  }
}
