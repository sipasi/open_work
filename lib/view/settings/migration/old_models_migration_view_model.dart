import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_work_flutter/data/models/calculation_type.dart';
import 'package:open_work_flutter/data/models/work.dart';
import 'package:open_work_flutter/data/models/work_day.dart';
import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/data/models/work_type.dart';
import 'package:open_work_flutter/data/models/work_unit.dart';
import 'package:open_work_flutter/services/navigation/material_navigator.dart';
import 'package:open_work_flutter/storage/month_storage.dart';
import 'package:open_work_flutter/view/settings/migration/old_models/calculation_type_old.dart';
import 'package:open_work_flutter/view/settings/migration/old_models/work_month_old.dart';
import 'package:open_work_flutter/view/settings/migration/work_month_old_json_parcer.dart';
import 'package:open_work_flutter/view/shared/selectable/selectable_items_model.dart';

class OldModelsMigrationViewModel {
  late SelectableItemsModel<WorkMonth> selectable = SelectableItemsModel([]);

  final MonthStorage storage;

  OldModelsMigrationViewModel(this.storage);

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

      final olds = WorkMonthOldJsonParcer().from(text);

      final list = _migrate(olds);

      items.addAll(list);
    }

    selectable = SelectableItemsModel<WorkMonth>(items);
  }

  Future onMigrate(BuildContext context) async {
    for (var i = 0; i < selectable.items.length; i++) {
      final item = selectable.items[i];

      await storage.updateOrCreate(item);
    }

    if (context.mounted) MaterialNavigator.pop(context);
  }

  List<WorkMonth> _migrate(List<WorkMonthOld> olds) {
    final types = <WorkType>[];

    return olds
        .map(
          (old) => WorkMonth(
            date: old.date,
            days: old.days
                .map(
                  (day) => WorkDay(
                    date: day.date,
                    works: day.works.map(
                      (work) {
                        final type = WorkType(
                          calculation:
                              work.calculation == CalculationTypeOld.hour
                                  ? CalculationType.numbersSum
                                  : CalculationType.itemsCount,
                          name: work.type,
                          price: work.price,
                        );

                        if (types.contains(type) == false) {
                          types.add(type);
                        }

                        return Work(
                          type,
                          work.description
                              .split(',')
                              .map((e) => e.trim())
                              .where((element) => element.isEmpty)
                              .map(WorkUnit.new)
                              .toList(),
                        );
                      },
                    ).toList(),
                  ),
                )
                .toList(),
            types: types,
          ),
        )
        .toList();
  }
}
