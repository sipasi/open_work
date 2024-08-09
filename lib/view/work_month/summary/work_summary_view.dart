import 'dart:math';

import 'package:flutter/material.dart';
import 'package:open_work_flutter/data/summaries/summary_model.dart';
import 'package:open_work_flutter/theme/theme_extension.dart';
import 'package:open_work_flutter/view/shared/layouts/separated_column.dart';
import 'package:open_work_flutter/view/work_month/summary/table_builder.dart';

class WorkSummaryView extends StatelessWidget {
  final List<WorkInfo> summary;

  const WorkSummaryView({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final scheme = context.colorScheme;

    final headerStyle = textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.bold,
    );

    final titleStyle = textTheme.bodyLarge?.copyWith(
      color: scheme.primary,
    );

    return SeparatedColumn(
      separator: (context, index) => const Divider(),
      children: List.generate(
        summary.length,
        (index) {
          final info = summary[index];

          double width = MediaQuery.of(context).size.width;

          final count = max(1, width / 130).toInt();

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(info.type.name, style: headerStyle),
                const SizedBox(height: 10),
                TableBuilder.columns(
                  count: count,
                  elements: info.summaries,
                  builder: (data) {
                    final title = '${data.unit.value} (${data.dates.length})';
                    final days = data.dates.map((e) => e.day).join(', ');

                    return ListTile(
                      title: Text(title, textAlign: TextAlign.center),
                      titleTextStyle: titleStyle,
                      subtitle: Text(days, textAlign: TextAlign.center),
                      contentPadding: EdgeInsets.zero,
                      onTap: () {},
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
