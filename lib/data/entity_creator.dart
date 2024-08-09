import 'package:open_work_flutter/data/models/calculation_type.dart';
import 'package:open_work_flutter/data/models/work_day.dart';
import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/data/models/work_type.dart';

class EntityCreator {
  static WorkType workType({
    String? id,
    required String name,
    required CalculationType calculation,
    required double price,
  }) =>
      WorkType(
        name: name,
        calculation: calculation,
        price: price,
      );

  static WorkMonth workMonth({
    String? id,
    required int year,
    required int month,
    required List<WorkType> types,
  }) {
    return WorkMonth(
      date: DateTime(year, month),
      types: types,
      days: emptyDays(year: year, month: month),
    );
  }

  static List<WorkDay> emptyDays({required int year, required int month}) {
    int days = dayCount(year: year, month: month);

    return List.generate(
      days,
      growable: false,
      (index) => WorkDay(
        date: DateTime(year, month, index + 1),
        works: List.empty(growable: true),
      ),
    );
  }

  static int dayCount({required int year, required int month}) =>
      DateTime(year, month + 1, 0).day;
}
