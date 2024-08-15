import 'calculation_type_old.dart';
import 'work_old.dart';

class WorkCalculatorOld {
  static double calculate(WorkOld work) => switch (work.calculation) {
        CalculationTypeOld.commaSeparator => _calculateComma(work),
        CalculationTypeOld.hour => _calculateHour(work),
        // ignore: unreachable_switch_case
        _ => 0,
      };

  static double calculateWorks(List<WorkOld>? works) {
    if (works == null || works.isEmpty) {
      return 0;
    }

    if (works.length == 1) {
      return calculate(works[0]);
    }

    double result = works.map((e) => calculate(e)).reduce((value, element) => value + element);

    return _toPrecision(result);
  }

  static int workCommaCount(WorkOld work) {
    int count = 0;

    final chars = work.description.codeUnits;

    final comma = ','.codeUnitAt(0);

    for (var i = 0; i < chars.length; i++) {
      if (chars[i] == comma) {
        count++;
      }
    }

    return count;
  }

  static int worksCommaCount(List<WorkOld> works) {
    if (works.isEmpty) return 0;

    int sum = 0;

    for (var work in works) {
      if (work.description.isEmpty) {
        continue;
      }

      sum += workCommaCount(work) + 1; // last item without comma
    }

    return sum;
  }

  static double _calculateComma(WorkOld work) {
    int length = work.description.split(',').length;

    double result = _toPrecision(length * work.price);

    return result;
  }

  static double _calculateHour(WorkOld work) {
    List<String>? splitted = work.description.split(',');

    if (splitted.isEmpty) {
      return 0;
    }

    Iterable<double> numbers = splitted.map((e) => double.tryParse(e) ?? 0);

    double result = numbers.reduce(
      (value, element) => value + element,
    );

    return _toPrecision(result * work.price);
  }

  static double _toPrecision(double number) => double.parse(number.toStringAsFixed(2));
}
