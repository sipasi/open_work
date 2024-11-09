import 'package:flutter/material.dart';
import 'package:open_work_flutter/data/models/calculation_type.dart';

class CalculationSegmentedButton extends StatelessWidget {
  final CalculationType selected;
  final void Function(CalculationType calculation) onSelected;

  const CalculationSegmentedButton({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<CalculationType>(
      segments: [
        ButtonSegment(
          value: CalculationType.itemsCount,
          label: Text('count items'),
          enabled: true,
        ),
        ButtonSegment(
          value: CalculationType.numbersSum,
          label: Text('sum numbers'),
        ),
      ],
      selected: {selected},
      onSelectionChanged: (set) => onSelected(set.first),
    );
  }
}
