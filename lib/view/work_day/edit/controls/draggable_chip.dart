import 'package:flutter/material.dart';
import 'package:open_work_flutter/data/models/work_unit.dart';

class DraggableChip extends StatelessWidget {
  final WorkUnit text;

  final void Function(WorkUnit text) onDragCompleted;
  final void Function(WorkUnit text) onPressed;

  const DraggableChip({
    super.key,
    required this.text,
    required this.onPressed,
    required this.onDragCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable<WorkUnit>(
      data: text,
      feedback: Text(
        text.value,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      hapticFeedbackOnStart: true,
      onDragCompleted: () => onDragCompleted(text),
      child: OutlinedButton(
        onPressed: () => onPressed(text),
        child: Text(text.value),
      ),
    );
  }
}
