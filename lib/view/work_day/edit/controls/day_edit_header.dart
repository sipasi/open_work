import 'package:flutter/material.dart';
import 'package:open_work_flutter/data/models/work_type.dart';

class DayEditHeader extends StatelessWidget {
  final WorkType type;
  final String sum;

  const DayEditHeader({
    super.key,
    required this.type,
    required this.sum,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle? header = Theme.of(context).textTheme.titleMedium;

    final TextStyle? typeStyle = header?.copyWith(
      color: Theme.of(context).colorScheme.primary,
    );

    return Row(
      children: [
        Expanded(
          child: Text(
            type.name,
            style: typeStyle,
            textAlign: TextAlign.start,
          ),
        ),
        Expanded(
          child: Text(
            type.price.toString(),
            style: header,
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Text(
            sum,
            style: header,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
