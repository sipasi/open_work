import 'package:open_work_flutter/data/models/calculation_type.dart';

class WorkInputValidator {
  const WorkInputValidator();

  (bool error, String? message) validate(
      String input, CalculationType calculation) {
    if (input.isEmpty) {
      return (true, 'Can\'t add empty work');
    }

    if (calculation == CalculationType.numbersSum &&
        double.tryParse(input) == null) {
      return (true, 'Calculation type "numbers" only allow number');
    }

    return (false, null);
  }
}
