import 'package:flutter/material.dart';
import 'package:open_work_flutter/theme/theme_extension.dart';
import 'package:open_work_flutter/view/work_month/list/month_picker/month_list.dart';
import 'package:open_work_flutter/view/work_month/list/month_picker/month_value.dart';

class MonthGridView extends StatelessWidget {
  final MonthList list;

  final void Function(MonthValue value) onSelected;
  final void Function(MonthValue value) onDeleted;

  const MonthGridView({
    super.key,
    required this.list,
    required this.onSelected,
    required this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = context.colorScheme;

    return GridView.count(
      crossAxisCount: 4,
      children: List.generate(
        list.length,
        (index) {
          final month = list[index];

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              onTap: () =>
                  month.selected ? onDeleted(month) : onSelected(month),
              child: Container(
                decoration: ShapeDecoration(
                  color: month.selected ? scheme.secondaryContainer : null,
                  shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    side: BorderSide(color: scheme.primary),
                  ),
                ),
                child: Center(
                    child: Text(
                  '${month.value}',
                )),
              ),
            ),
          );
        },
      ),
    );
  }
}
