import 'package:open_work_flutter/data/models/work_month.dart';

import 'json_parcer.dart';
import 'work_month_json_parcer.dart';

abstract class ImportExportJson {
  static JsonParcer<List<WorkMonth>> month = WorkMonthJsonParcer();
}
