import 'dart:convert';

import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/services/export/formatter/format_options.dart';
import 'package:open_work_flutter/services/export/work_month/work_month_formatter.dart';
import 'package:open_work_flutter/view/settings/export_import/data/json/import_export_json.dart';

class JsonFormatter extends WorkMonthFormatter {
  @override
  Future<List<int>> format(List<WorkMonth> data, FormatOptions options) {
    String result = ImportExportJson.month.to(data);

    final bytes = utf8.encode(result);

    return Future.value(bytes);
  }
}
