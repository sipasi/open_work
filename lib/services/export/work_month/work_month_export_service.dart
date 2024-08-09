import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/services/export/export_service.dart';

class WorkMonthExportService extends ExportService<List<WorkMonth>> {
  WorkMonthExportService(super.factory, super.path, super.save);
}
