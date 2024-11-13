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

  const SummaryModel.empty()
      : this(
          total: 0,
          calculations: const [],
          types: const [],
          works: const [],
        );

  SummaryModel copyWith({
    double? total,
    List<CalculationInfo>? calculations,
    List<TypeInfo>? types,
    List<WorkInfo>? works,
  }) {
    return SummaryModel(
      total: total ?? this.total,
      calculations:
          calculations ?? this.calculations.map((e) => e.copy()).toList(),
      types: types ?? this.types.map((e) => e.copy()).toList(),
      works: works ?? this.works.map((e) => e.copy()).toList(),
    );
  }
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

  CalculationInfo copy() {
    return CalculationInfo(
      calculation: calculation,
      count: count,
      sum: sum,
      units: units.toList(),
    );
  }
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

  TypeInfo copy() {
    return TypeInfo(
      type: type,
      count: count,
      sum: sum,
      units: units.toList(),
    );
  }
}

class WorkInfo {
  final WorkType type;

  final List<UnitDaysPairs> summaries;

  WorkInfo(this.type, this.summaries);

  WorkInfo copy() {
    return WorkInfo(type, summaries.map((e) => e.copy()).toList());
  }
}

class UnitDaysPairs {
  final WorkUnit unit;
  final List<DateTime> dates;

  UnitDaysPairs(this.unit, this.dates);

  UnitDaysPairs copy() {
    return UnitDaysPairs(unit, dates.toList());
  }
}
