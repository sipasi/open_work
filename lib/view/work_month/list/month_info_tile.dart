import 'package:flutter/material.dart';

import '../../../theme/theme_extension.dart';
import 'work_month_details.dart';

class MonthInfoTile extends StatelessWidget {
  final WorkMonthDetails month;

  final void Function() onTap;

  const MonthInfoTile({
    super.key,
    required this.month,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    final titleStyle = textTheme.bodyLarge?.copyWith(
      color: colorScheme.primary,
    );

    final date = month.date;

    return Card.outlined(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${date.year}-${date.month}', style: titleStyle),
              const Spacer(),
              Text('${month.sum}'),
            ],
          ),
        ),
      ),
    );
  }
}
