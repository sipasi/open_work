import 'package:open_work_flutter/collection/extension/linq_iterable.dart';
import 'package:open_work_flutter/data/calculations/work_list_calculation_extension.dart';
import 'package:open_work_flutter/data/models/work_day.dart';
import 'package:open_work_flutter/data/models/work_month.dart';

class WorkMonthDetails {
  final WorkMonth month;

  final double sum;

  int get id => month.id!;

  DateTime get date => month.date;

  List<WorkDay> get days => month.days;

  WorkMonthDetails.from(this.month)
      : sum = month.days.sumBy((day) => day.works.calculate()).toDouble();
}
