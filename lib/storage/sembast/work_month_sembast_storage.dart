import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/storage/month_storage.dart';
import 'package:open_work_flutter/storage/sembast/sembast_storage.dart';

class WorkMonthSembastStorage extends SembastStorage<WorkMonth>
    implements MonthStorage {
  WorkMonthSembastStorage({required super.database, required super.name});

  @override
  WorkMonth fromJson(Map<String, dynamic> json) => WorkMonth.fromJson(json);

  @override
  Map<String, dynamic> toJson(WorkMonth entity) => entity.toJson();

  @override
  int? getId(WorkMonth entity) {
    return entity.id;
  }
}
