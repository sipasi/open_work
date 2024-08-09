import 'package:flutter/material.dart';
import 'package:open_work_flutter/data/models/work_unit.dart';
import 'package:open_work_flutter/view/work_day/edit/controls/day_edit_drop_zone.dart';

import 'draggable_chip.dart';

class DayEditChips extends StatelessWidget {
  final List<WorkUnit> units;

  final double spacing;
  final double runSpacing;

  final void Function(WorkUnit unit) onChipPressed;
  final bool Function(WorkUnit? unit) onDropWillAccept;
  final void Function(WorkUnit unit) onDropAccept;
  final void Function(WorkUnit unit) onDragCompleted;
  final void Function() onDropZoneTapped;

  const DayEditChips({
    super.key,
    required this.units,
    required this.onChipPressed,
    required this.onDropWillAccept,
    required this.onDropAccept,
    required this.onDragCompleted,
    required this.onDropZoneTapped,
    this.spacing = 10,
    this.runSpacing = 4,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget<WorkUnit>(
      builder: (context, candidateItems, rejectedItems) => _body(),
      onWillAcceptWithDetails: (data) => onDropWillAccept(data.data),
      onAcceptWithDetails: (data) => onDropAccept(data.data),
    );
  }

  Widget _body() {
    final body = units.isNotEmpty
        ? Wrap(
            spacing: spacing,
            runSpacing: runSpacing,
            children: toChips(),
          )
        : DayEditDropZone(
            onTapped: onDropZoneTapped,
          );

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 68),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: body,
      ),
    );
  }

  List<DraggableChip> toChips() {
    return List.generate(
      units.length,
      (index) {
        return DraggableChip(
          text: units[index],
          onPressed: onChipPressed,
          onDragCompleted: onDragCompleted,
        );
      },
    );
  }
}
