// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:open_work_flutter/data/models/calculation_type.dart';

class CalculationTypeDropdown extends StatelessWidget {
  final CalculationType initialSelection;
  final void Function(CalculationType calculation) onSelected;

  const CalculationTypeDropdown({
    super.key,
    required this.initialSelection,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    const values = CalculationType.values;

    return DropdownMenu<CalculationType>(
      initialSelection: initialSelection,
      leadingIcon: const Icon(Icons.calculate_outlined),
      onSelected: (value) => onSelected(value!),
      expandedInsets: EdgeInsets.zero,
      dropdownMenuEntries: List.generate(
        values.length,
        (index) {
          return DropdownMenuEntry<CalculationType>(
            value: values[index],
            label: values[index].name,
          );
        },
      ),
    );
  }
}
