import 'package:flutter/material.dart';
import 'package:open_work_flutter/data/summaries/summary_model.dart';
import 'package:open_work_flutter/theme/theme_extension.dart';
import 'package:open_work_flutter/view/shared/layouts/separated_column.dart';

class CalculationSummaryView extends StatelessWidget {
  final List<CalculationInfo> summary;

  final Widget Function(CalculationInfo info, int index) builder;

  const CalculationSummaryView({
    super.key,
    required this.summary,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return SeparatedColumn(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      separator: (context, index) => const Divider(height: 0),
      children: List.generate(
        summary.length,
        (index) => builder(summary[index], index),
      ),
    );
  }
}

class CalculationSummaryTile extends StatelessWidget {
  final CalculationInfo info;

  final void Function()? onTap;

  final TextStyle? subtitleStyle;
  final Widget? trailing;
  final Widget? leading;

  final ListTileTitleAlignment? titleAlignment;

  const CalculationSummaryTile({
    super.key,
    required this.info,
    this.onTap,
    this.trailing,
    this.leading,
    this.subtitleStyle,
    this.titleAlignment = ListTileTitleAlignment.titleHeight,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final titleText = textTheme.bodyLarge?.copyWith(
      fontWeight: FontWeight.bold,
    );
    final subtitleText = subtitleStyle ??
        textTheme.bodyMedium?.copyWith(
          color: Colors.green.shade400,
        );

    final type = info.calculation;

    return ListTile(
      title: Text(type.name, style: titleText),
      subtitle: Text(info.sum.toString(), style: subtitleText),
      leading: leading,
      trailing: trailing,
      onTap: onTap,
      titleAlignment: titleAlignment,
    );
  }
}
