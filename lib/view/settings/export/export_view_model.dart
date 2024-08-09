import 'package:flutter/material.dart';
import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/services/navigation/material_navigator.dart';
import 'package:open_work_flutter/storage/month_storage.dart';
import 'package:open_work_flutter/view/settings/export/option/export_options_page.dart';
import 'package:open_work_flutter/view/shared/selectable/selectable_items_model.dart';

class ExportViewModel {
  final MonthStorage _storage;

  late final SelectableItemsModel<WorkMonth> selectable;

  ExportViewModel(this._storage);

  Future load() async {
    final all = await _storage.getAll();

    selectable = SelectableItemsModel(all);
  }

  Future toExportDestination(BuildContext context) {
    return MaterialNavigator.push(
      context,
      (context) => ExportOptionsPage(groups: selectable.getSelected()),
    );
  }

  bool canShare() {
    return selectable.isNotEmpty;
  }
}
