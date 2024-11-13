import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/storage/month_storage.dart';
import 'package:open_work_flutter/storage/sembast/sembast_storage.dart';
import 'package:sembast/sembast.dart';

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

  @override
  Future<bool> containsMonth(DateTime date) async {
    final id = await getIdByDate(date);

    return id != null;
  }

  @override
  Future updateOrCreateByDate(WorkMonth month) async {
    final copy = month.copyWith(
      id: await getIdByDate(month.date),
    );

    return updateOrCreate(copy);
  }

  Future<int?> getIdByDate(DateTime date) async {
    final finder = Finder(
      filter: Filter.matchesRegExp('date', regexFromYearMonth(date)),
    );

    final result = await store.findFirst(
      database,
      finder: finder,
    );

    return result?.key;
  }

  RegExp regexFromYearMonth(DateTime date) {
    final source =
        date.toIso8601String().substring(0, 7); // 1969-07-20 -> 1969-07

    return RegExp('^$source');
  }
}
