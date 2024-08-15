import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_work_flutter/services/navigation/material_navigator.dart';
import 'package:open_work_flutter/storage/month_storage.dart';
import 'package:open_work_flutter/storage/type_storage.dart';
import 'package:open_work_flutter/view/settings/export/export_page.dart';
import 'package:open_work_flutter/view/settings/import/import_page.dart';
import 'package:open_work_flutter/view/settings/migration/old_models_migration_page.dart';
import 'package:open_work_flutter/view/settings/theme_controller.dart';
import 'package:open_work_flutter/view/shared/dialogs/delete_dialog.dart';
import 'package:open_work_flutter/view/shared/dialogs/waiting_dialog.dart';

import 'summary/all_summary_view.dart';

class SettingsViewModel {
  final ThemeController themeController;

  SettingsViewModel(StateSetter updateState)
      : themeController = ThemeController(updateState);

  Future toImport(BuildContext context) =>
      MaterialNavigator.push(context, (context) => const ImportPage());
  Future toExport(BuildContext context) =>
      MaterialNavigator.push(context, (context) => const ExportPage());

  Future toMigration(BuildContext context) => MaterialNavigator.push(
      context, (context) => const OldModelsMigrationPage());

  Future toSummarizeAll(BuildContext context) =>
      MaterialNavigator.push(context, (context) => const AllSummaryView());

  Future deleteAll(BuildContext context) async {
    bool result = await DeleteDialog.showMessage(
      context: context,
      message: 'This action delete all months and types',
    );

    if (result == false) {
      return;
    }
    if (context.mounted) {
      WaitingDialog.show(
        context: context,
        title: 'Deleting...',
        future: Future(() {
          final typeStorage = GetIt.I.get<TypeStorage>();
          final monthStorage = GetIt.I.get<MonthStorage>();

          return Future.wait(
            [
              typeStorage.clear(),
              monthStorage.clear(),
            ],
          );
        }),
      );
    }
  }
}
