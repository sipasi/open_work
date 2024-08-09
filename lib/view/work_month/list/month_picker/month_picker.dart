import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_work_flutter/view/shared/dialogs/delete_dialog.dart';

import 'month_grid_view.dart';
import 'month_list.dart';
import 'month_value.dart';

class MonthPicker extends StatefulWidget {
  final int initialYear;

  final void Function(int year, MonthList months) onYearChanged;
  final void Function(int year, MonthValue month) onMonthSelected;
  final void Function(int year, MonthValue month) onMonthDeleted;

  const MonthPicker({
    super.key,
    required this.initialYear,
    required this.onYearChanged,
    required this.onMonthSelected,
    required this.onMonthDeleted,
  });

  @override
  State<StatefulWidget> createState() => _MonthPickerState();
}

class _MonthPickerState extends State<MonthPicker> {
  late int year;

  late final MonthList monthes;

  @override
  void initState() {
    super.initState();

    year = widget.initialYear;
    monthes = MonthList();

    widget.onYearChanged(year, monthes);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            children: [
              Expanded(
                child: IconButton(
                  icon: const Icon(Icons.navigate_before),
                  onPressed: () => _changeYear(value: year - 1),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  '$year',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: const Icon(Icons.navigate_next),
                  onPressed: () => _changeYear(value: year + 1),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: MonthGridView(
            list: monthes,
            onDeleted: (value) => _onDeleted(context, value),
            onSelected: (value) => _onSelected(value),
          ),
        )
      ],
    );
  }

  void _changeYear({required int value}) {
    setState(() {
      year = value;

      widget.onYearChanged(value, monthes);
    });
  }

  Future _onDeleted(BuildContext context, MonthValue month) async {
    String monthName = DateFormat.MMMM().format(month.asDateTime(year: year));

    bool result = await DeleteDialog.showMessage(
      context: context,
      title: 'Attention',
      message: 'Do you want delete a $monthName of $year',
    );

    if (result == true) {
      widget.onMonthDeleted(year, month);

      setState(() {});
    }
  }

  void _onSelected(MonthValue month) async {
    widget.onMonthSelected(year, month);

    setState(() {});
  }
}
