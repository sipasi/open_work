import 'package:open_work_flutter/services/export/export_format.dart';
import 'package:open_work_flutter/services/export/formatter/data_formatter.dart';

abstract class DataFormatterFactory<T> {
  DataFormatter<T> create(ExportFormat format);
}
