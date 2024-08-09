import 'package:flutter/material.dart';
import 'package:open_work_flutter/collection/linq_iterable.dart';
import 'package:open_work_flutter/data/models/calculation_type.dart';
import 'package:open_work_flutter/data/summaries/summary_model.dart';
import 'package:open_work_flutter/theme/theme_extension.dart';
import 'package:open_work_flutter/view/shared/layouts/separated_column.dart';

class TypeSummaryView extends StatelessWidget {
  final List<TypeInfo> summary;

  final Widget Function(TypeInfo info, int index) builder;

  const TypeSummaryView({
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

class TypeSummaryTile extends StatelessWidget {
  final TypeInfo info;

  final void Function()? onTap;

  final TextStyle? subtitleStyle;
  final Widget? trailing;
  final Widget? leading;

  final ListTileTitleAlignment? titleAlignment;

  const TypeSummaryTile({
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

    final type = info.type;

    return ListTile(
      title: Text(type.name, style: titleText),
      subtitle: formulaTile(info, subtitleText),
      leading: leading,
      trailing: trailing,
      onTap: onTap,
      titleAlignment: titleAlignment,
    );
  }

  Widget formulaTile(TypeInfo info, TextStyle? style) {
    if (info.units.isEmpty) {
      return Text('empty yet', style: style);
    }

    final sum = info.sum.toString();
    final price = info.type.price.toString();

    final formula = switch (info.type.calculation) {
      CalculationType.itemsCount => '${info.count} * $price',
      CalculationType.numbersSum => '${unitsSum()} * $price',
    };

    return Text('$sum = $formula', style: style);
  }

  double unitsSum() {
    return info.units
        .sumBy((element) => double.tryParse(element.value) ?? 0)
        .toDouble();
  }
}
