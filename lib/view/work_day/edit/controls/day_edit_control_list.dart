import 'package:flutter/material.dart';
import 'package:open_work_flutter/data/models/work.dart';
import 'package:open_work_flutter/data/models/work_day.dart';

import 'day_edit_control.dart';

class DayEditControlList extends StatefulWidget {
  final WorkDay day;

  const DayEditControlList({super.key, required this.day});

  @override
  State<DayEditControlList> createState() => _DayEditControlListState();
}

class _DayEditControlListState extends State<DayEditControlList> {
  @override
  Widget build(BuildContext context) {
    List<Work> works = widget.day.works;

    return ListView.separated(
      itemCount: works.length,
      padding: const EdgeInsets.only(top: 10, bottom: 30),
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: DayEditControl(work: works[index]),
      ),
    );
  }
}
