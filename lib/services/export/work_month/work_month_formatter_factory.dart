import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/services/export/export_format.dart';
import 'package:open_work_flutter/services/export/formatter/data_formatter.dart';
import 'package:open_work_flutter/services/export/formatter/data_formatter_factory.dart';
import 'package:open_work_flutter/services/export/work_month/json_formatter.dart';
import 'package:open_work_flutter/services/export/work_month/text_formatter.dart';

class WorkMonthFormatterFactory extends DataFormatterFactory<List<WorkMonth>> {
  @override
  DataFormatter<List<WorkMonth>> create(ExportFormat format) =>
      switch (format) {
        ExportFormat.json => JsonFormatter(),
        ExportFormat.text => TextFormatter(),
      };
}
