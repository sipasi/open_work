import 'package:open_work_flutter/collection/linq_iterable.dart';
import 'package:open_work_flutter/data/models/calculation_type.dart';
import 'package:open_work_flutter/data/models/work.dart';

class WorkCalculator {
  static double one(Work work) => switch (work.type.calculation) {
        CalculationType.itemsCount => _calculateItems(work),
        CalculationType.numbersSum => _calculateNumbers(work),
      };

  static double many(List<Work>? works) {
    if (works == null || works.isEmpty) {
      return 0;
    }

    if (works.length == 1) {
      return one(works.first);
    }

    double result = works.map(one).sumDouble();

    return _toPrecision(result);
  }

  static double _calculateItems(Work work) {
    return work.units.length * work.type.price;
  }

  static double _calculateNumbers(Work work) {
    double sum =
        work.units.map((e) => double.tryParse(e.value) ?? 0.0).sumDouble();

    return sum * work.type.price;
  }

  static double _toPrecision(double number) =>
      double.parse(number.toStringAsFixed(2));
}
