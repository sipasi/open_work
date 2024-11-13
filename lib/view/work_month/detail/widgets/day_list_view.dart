import 'package:flutter/material.dart';
import 'package:open_work_flutter/data/models/work_day.dart';
import 'package:open_work_flutter/view/work_month/detail/widgets/day_tile.dart';

class DayListView extends StatelessWidget {
  final List<WorkDay> days;

  final void Function(WorkDay day) onTap;

  const DayListView({super.key, required this.days, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: days.length,
      padding: const EdgeInsets.only(bottom: 85),
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (_, index) {
        final day = days[index];

        return DayTile(
          day: day,
          onTap: () => onTap(day),
        );
      },
    );
  }
}
