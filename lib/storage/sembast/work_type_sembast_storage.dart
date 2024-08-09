import 'package:open_work_flutter/data/models/work_type.dart';
import 'package:open_work_flutter/storage/sembast/sembast_storage.dart';
import 'package:open_work_flutter/storage/type_storage.dart';

class WorkTypeSembastStorage extends SembastStorage<WorkType>
    implements TypeStorage {
  WorkTypeSembastStorage({required super.database, required super.name});

  @override
  int? getId(WorkType entity) {
    return entity.id;
  }

  @override
  WorkType fromJson(Map<String, dynamic> json) => WorkType.fromJson(json);

  @override
  Map<String, dynamic> toJson(WorkType entity) => entity.toJson();
}
