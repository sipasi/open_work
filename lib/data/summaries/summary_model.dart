import 'package:open_work_flutter/data/models/calculation_type.dart';
import 'package:open_work_flutter/data/models/work_type.dart';
import 'package:open_work_flutter/data/models/work_unit.dart';

class SummaryModel {
  final double total;
  final List<CalculationInfo> calculations;
  final List<TypeInfo> types;
  final List<WorkInfo> works;

  const SummaryModel({
    required this.total,
    required this.calculations,
    required this.types,
    required this.works,
  });
}

class CalculationInfo {
  final CalculationType calculation;
  final int count;
  final double sum;
  final List<WorkUnit> units;

  const CalculationInfo({
    required this.calculation,
    required this.count,
    required this.sum,
    required this.units,
  });
}

class TypeInfo {
  final WorkType type;
  final int count;
  final double sum;
  final List<WorkUnit> units;

  const TypeInfo({
    required this.type,
    required this.count,
    required this.sum,
    required this.units,
  });
  const TypeInfo.empty({required this.type})
      : count = 0,
        sum = 0,
        units = const [];
}

class WorkInfo {
  final WorkType type;

  final List<UnitDaysPairs> summaries;

  WorkInfo(this.type, this.summaries);
}

class UnitDaysPairs {
  final WorkUnit unit;
  final List<DateTime> dates;

  UnitDaysPairs(this.unit, this.dates);
}
