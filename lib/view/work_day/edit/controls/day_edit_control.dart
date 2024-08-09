import 'package:flutter/material.dart';
import 'package:open_work_flutter/data/calculations/work_calculator.dart';
import 'package:open_work_flutter/data/models/calculation_type.dart';
import 'package:open_work_flutter/data/models/work.dart';
import 'package:open_work_flutter/data/models/work_type.dart';
import 'package:open_work_flutter/data/models/work_unit.dart';
import 'package:open_work_flutter/view/shared/input_fields/text_edit_controller.dart';
import 'package:open_work_flutter/view/work_day/edit/controls/day_edit_chips.dart';
import 'package:open_work_flutter/view/work_day/edit/controls/day_edit_header.dart';
import 'package:open_work_flutter/view/work_day/edit/controls/work_input_field.dart';
import 'package:open_work_flutter/view/work_day/edit/controls/work_input_validator.dart';

class DayEditControl extends StatefulWidget {
  final Work work;

  const DayEditControl({super.key, required this.work});

  @override
  State<DayEditControl> createState() => _DayEditControlState();
}

class _DayEditControlState extends State<DayEditControl> {
  final controller = TextEditController.text(focusNode: FocusNode());

  Work get work => widget.work;
  WorkType get type => work.type;
  List<WorkUnit> get units => work.units;

  @override
  Widget build(BuildContext context) {
    final work = widget.work;
    final units = work.units;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DayEditHeader(
          type: work.type,
          sum: WorkCalculator.one(work).toString(),
        ),
        const SizedBox(height: 10),
        DayEditChips(
          units: units,
          onChipPressed: _onChipPressed,
          onDropWillAccept: _onDropWillAccept,
          onDropAccept: _onDropAccept,
          onDragCompleted: _onDragCompleted,
          onDropZoneTapped: () => controller.setFocus(),
        ),
        WorkInputField(
          calculation: work.type.calculation,
          validator: const WorkInputValidator(),
          controller: controller,
          onSubmit: _onTextFieldSubmit,
        ),
      ],
    );
  }

  static int? _indexByIdentical(List<WorkUnit> list, WorkUnit unit) {
    int index = list.indexWhere((element) => identical(unit, element));

    return index == -1 ? null : index;
  }

  void _onChipPressed(WorkUnit unit) {
    setState(() {
      int? index = _indexByIdentical(units, unit);

      if (index == null) {
        return;
      }

      units.removeAt(index);

      controller.setText(unit.value);
    });
  }

  bool _onDropWillAccept(WorkUnit? unit) {
    if (unit == null) return false;

    if (type.calculation == CalculationType.numbersSum &&
        double.tryParse(unit.value) == null) {
      return false;
    }

    return true;
  }

  void _onDropAccept(WorkUnit unit) {
    setState(() {
      units.add(unit);

      controller.clear();
    });
  }

  void _onDragCompleted(WorkUnit unit) {
    setState(() {
      int? index = _indexByIdentical(units, unit);

      if (index == null) {
        return;
      }

      units.removeAt(index);
    });
  }

  void _onTextFieldSubmit(String value) {
    setState(() {
      final iterable = value
          .split(',')
          .map((element) => element.trim())
          .where((element) => element.isNotEmpty)
          .map((element) => WorkUnit(element));

      units.addAll(iterable);
    });
  }
}
