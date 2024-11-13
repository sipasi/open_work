import 'package:flutter/material.dart';
import 'package:open_work_flutter/collection/linq_iterable.dart';
import 'package:open_work_flutter/data/models/calculation_type.dart';
import 'package:open_work_flutter/data/models/work_type.dart';
import 'package:open_work_flutter/data/models/work_unit.dart';

class WorkUnitFormula extends StatelessWidget {
  final double sum;
  final double price;

  /// represent count of units or sum of the units
  final double amount;

  final bool empty;

  final TextStyle? style;
  final TextStyle? emptyStyle;

  const WorkUnitFormula({
    super.key,
    required this.sum,
    required this.price,
    required this.amount,
    required this.empty,
    this.style,
    this.emptyStyle,
  });

  factory WorkUnitFormula.auto({
    required WorkType type,
    required List<WorkUnit> units,
    TextStyle? style,
    TextStyle? emptyStyle,
  }) {
    final amount = switch (type.calculation) {
      CalculationType.itemsCount => units.length,
      CalculationType.numbersSum =>
        units.sumBy((element) => double.tryParse(element.value) ?? 0)
    };

    return WorkUnitFormula(
      sum: amount * type.price,
      price: type.price,
      amount: amount.toDouble(),
      empty: units.isEmpty,
      style: style,
      emptyStyle: emptyStyle,
    );
  }

  @override
  Widget build(BuildContext context) {
    return empty
        ? Text('empty yet', style: emptyStyle ?? style)
        : Text('$sum = $amount * $price', style: style);
  }
}
