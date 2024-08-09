import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:open_work_flutter/data/models/work.dart';
import 'package:open_work_flutter/data/models/work_day.dart';
import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/services/navigation/material_navigator.dart';
import 'package:open_work_flutter/services/result.dart';
import 'package:open_work_flutter/storage/month_storage.dart';
import 'package:open_work_flutter/view/work_day/edit/controls/day_edit_control.dart';

class DayEditPage extends StatefulWidget {
  final WorkMonth month;
  final WorkDay day;

  const DayEditPage({super.key, required this.month, required this.day});

  @override
  State<DayEditPage> createState() => _DayEditPageState();
}

class _DayEditPageState extends State<DayEditPage> {
  late final WorkDay copy;

  @override
  void initState() {
    super.initState();

    final day = widget.day;

    copy = WorkDay.fromJson(day.toJson());

    for (var type in widget.month.types) {
      final contains = copy.works.cast<Work?>().firstWhere(
            (work) => work!.type == type,
            orElse: () => null,
          );

      if (contains != null) {
        continue;
      }

      copy.works.add(Work(type, []));

      copy.works.sort(
        (first, second) => first.type.name.compareTo(second.type.name),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Work> works = copy.works;

    return Scaffold(
      appBar: AppBar(
        title: Text(DateFormat(DateFormat.MONTH_DAY).format(widget.day.date)),
        actions: [
          IconButton(
            onPressed: () => _onSave(),
            icon: const Icon(Icons.save_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.separated(
          itemCount: works.length,
          padding: const EdgeInsets.only(top: 10, bottom: 30),
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: DayEditControl(work: works[index]),
          ),
        ),
      ),
    );
  }

  Future<void> _onSave() async {
    final storage = GetIt.I.get<MonthStorage>();

    final month = await storage.getBy(widget.month.id!);

    WorkDay day = copy;

    month!.days[day.date.day - 1] = day;

    day.works.removeWhere((element) => element.units.isEmpty);

    await storage.updateOrCreate(month);

    if (mounted) {
      MaterialNavigator.popWith(context, CrudResult.modify(month));
    }
  }
}
