import 'package:open_work_flutter/collection/extension/linq_iterable.dart';
import 'package:open_work_flutter/data/calculations/work_calculator.dart';
import 'package:open_work_flutter/data/models/work.dart';

extension WorkListCalculationExtension on List<Work> {
  double calculate() => WorkCalculator.many(this);

  int unitsCount() => sumBy((element) => element.units.length).toInt();
}
