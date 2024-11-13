import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/storage/entity_storage_async.dart';

abstract class MonthStorage extends EntityStorageAsync<int, WorkMonth> {
  Future<bool> containsMonth(DateTime date);
  Future updateOrCreateByDate(WorkMonth month);
}
