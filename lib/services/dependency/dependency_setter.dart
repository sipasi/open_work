import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:open_work_flutter/services/export/path_factory/system_path_factory.dart';
import 'package:open_work_flutter/services/export/path_factory/web_path_factory.dart';
import 'package:open_work_flutter/services/export/save_provider/local_saver.dart';
import 'package:open_work_flutter/services/export/save_provider/web_browser_saver.dart';
import 'package:open_work_flutter/services/export/work_month/work_month_export_service.dart';
import 'package:open_work_flutter/services/export/work_month/work_month_formatter_factory.dart';
import 'package:open_work_flutter/storage/month_storage.dart';
import 'package:open_work_flutter/storage/storage_factory.dart';
import 'package:open_work_flutter/storage/type_storage.dart';

abstract class AppDependencySetter {
  static Future set() async {
    final instance = GetIt.I;

    _registerExportService(instance);

    await _registerStorages(instance);

    instance.registerSingleton(Logger());
  }

  static Future _registerStorages(GetIt instance) async {
    final storage = await StorageFactory.createDefault();

    instance.registerSingleton<TypeStorage>(storage.$1);
    instance.registerSingleton<MonthStorage>(storage.$2);
  }

  static void _registerExportService(GetIt instance) {
    final factory = WorkMonthFormatterFactory();
    final path = _whenWeb(
      then: () => WebPathFactory(),
      other: () => SystemPathFactory(),
    );
    final saver = _whenWeb(
      then: () => WebBrowserSaver(),
      other: () => LocalSaver(),
    );

    final service = WorkMonthExportService(factory, path, saver);

    instance.registerSingleton<WorkMonthExportService>(service);
  }

  static T _whenWeb<T>(
      {required T Function() then, required T Function() other}) {
    return kIsWeb ? then() : other();
  }
}
