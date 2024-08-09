import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/services/navigation/material_navigator.dart';
import 'package:open_work_flutter/storage/month_storage.dart';
import 'package:open_work_flutter/view/settings/json/import_export_json.dart';
import 'package:open_work_flutter/view/shared/selectable/selectable_items_model.dart';

class ImportViewModel {
  late SelectableItemsModel<WorkMonth> selectable = SelectableItemsModel([]);

  final MonthStorage storage;

  ImportViewModel(this.storage);

  Future load() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      dialogTitle: 'Select json files',
      allowedExtensions: ['json'],
    );

    if (result == null || result.count == 0) {
      selectable = SelectableItemsModel([]);
      return;
    }

    final files = result.paths.map(
      (path) => File(path!),
    );

    List<WorkMonth> items = [];

    for (var file in files) {
      final bytes = await file.readAsBytes();

      final text = utf8.decode(bytes);

      final list = ImportExportJson.month.from(text);

      items.addAll(list);
    }

    selectable = SelectableItemsModel<WorkMonth>(items);
  }

  Future onImport(BuildContext context) async {
    for (var i = 0; i < selectable.items.length; i++) {
      final item = selectable.items[i];

      await storage.updateOrCreate(item);
    }

    if (context.mounted) MaterialNavigator.pop(context);
  }
}
