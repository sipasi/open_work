import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_work_flutter/data/calculations/work_calculator.dart';
import 'package:open_work_flutter/data/models/work.dart';
import 'package:open_work_flutter/data/models/work_day.dart';
import 'package:open_work_flutter/theme/theme_extension.dart';
import 'package:open_work_flutter/view/shared/layouts/separated_column.dart';

class DayTile extends StatelessWidget {
  final WorkDay day;

  final GestureTapCallback? onTap;

  final GestureLongPressCallback? onLongPress;

  const DayTile({
    super.key,
    required this.day,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) => ListTile(
        onTap: onTap,
        onLongPress: onLongPress,
        title: DayTileHeader(
          date: day.date,
          sum: WorkCalculator.many(day.works),
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(thickness: 4),
            DayTileBody(works: day.works),
          ],
        ),
      );
}

class DayTileHeader extends StatelessWidget {
  static final dayFormat = DateFormat('EEEE d');

  final DateTime date;
  final double sum;

  const DayTileHeader({
    super.key,
    required this.date,
    required this.sum,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle? style = context.textTheme.titleMedium?.copyWith(
      color: Theme.of(context).colorScheme.primary,
    );

    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(dayFormat.format(date), style: style),
      Text('$sum', style: style),
    ]);
  }
}

class DayTileBody extends StatelessWidget {
  final List<Work> works;

  const DayTileBody({super.key, required this.works});

  @override
  Widget build(BuildContext context) {
    if (works.isEmpty) {
      return const Text('Have no works');
    }

    return SeparatedColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      separator: (context, index) => const SizedBox(height: 10),
      children: _asRichTextList(context, works),
    );
  }

  static List<Widget> _asRichTextList(BuildContext context, List<Work> works) {
    final textTheme = context.textTheme;
    final scheme = context.colorScheme;

    final typeStyle = textTheme.bodyMedium?.copyWith(
      color: scheme.secondary,
      fontWeight: FontWeight.w500,
    );
    final desctiptionStyle = textTheme.bodyMedium?.copyWith(
      color: scheme.onSurface,
    );

    return List.generate(
      works.length,
      (index) {
        final work = works[index];
        return RichText(
          text: TextSpan(
            children: [
              TextSpan(text: work.type.name, style: typeStyle),
              TextSpan(text: ' (${work.units.length})', style: typeStyle),
              TextSpan(text: ':  ', style: typeStyle),
              TextSpan(
                text: work.units.map((e) => e.value).join(', '),
                style: desctiptionStyle,
              ),
            ],
          ),
        );
      },
    );
  }
}
