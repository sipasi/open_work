// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:open_work_flutter/data/models/work_day.dart';
import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/services/navigation/material_navigator.dart';
import 'package:open_work_flutter/services/result.dart';
import 'package:open_work_flutter/storage/month_storage.dart';
import 'package:open_work_flutter/view/work_day/edit/day_edit_page.dart';
import 'package:open_work_flutter/view/work_month/detail/day_tile.dart';
import 'package:open_work_flutter/view/work_month/edit/work_month_edit_page.dart';
import 'package:open_work_flutter/view/work_month/summary/month_summary_page.dart';

class WorkMonthDetailsPage extends StatefulWidget {
  final WorkMonth month;

  const WorkMonthDetailsPage({super.key, required this.month});

  @override
  State<WorkMonthDetailsPage> createState() => _WorkMonthDetailsPageState();
}

class _WorkMonthDetailsPageState extends State<WorkMonthDetailsPage> {
  late final WorkMonthDetailsViewModel viewmodel;

  final storage = GetIt.I.get<MonthStorage>();

  @override
  void initState() {
    super.initState();

    viewmodel = WorkMonthDetailsViewModel(widget.month);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(viewmodel.formattedDate),
        actions: [
          IconButton(
            onPressed: () =>
                viewmodel.onEditTap(context).then((value) => setState(() {})),
            icon: const Icon(Icons.edit_document),
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: viewmodel.days,
        padding: const EdgeInsets.only(bottom: 85),
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final date = viewmodel.dayAt(index);

          return DayTile(
            day: date,
            onTap: () => viewmodel
                .onDayTap(context, date)
                .then((value) => setState(() {})),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => viewmodel.onSummarizeTap(context),
        label: const Text('Summarize'),
      ),
    );
  }
}

class WorkMonthDetailsViewModel {
  final DateFormat _dayFormat = DateFormat.MMMM();

  WorkMonth _copy;

  int get days => _copy.days.length;
  DateTime get date => _copy.date;

  String get formattedDate => _dayFormat.format(date);

  WorkMonthDetailsViewModel(WorkMonth month)
      : _copy = WorkMonth.fromJson(month.toJson());

  WorkDay dayAt(int index) => _copy.days[index];

  Future onDayTap(BuildContext context, WorkDay day) async {
    final result = await MaterialNavigator.push(
      context,
      (context) => DayEditPage(month: _copy, day: day),
    );

    result.contained<WorkMonth>((item) {
      _copy = item;
    });
  }

  Future onSummarizeTap(BuildContext context) {
    return MaterialNavigator.push(
      context,
      (context) => MonthSummaryPage(
        month: _copy,
      ),
    );
  }

  Future onEditTap(BuildContext context) async {
    final result = await MaterialNavigator.push(
      context,
      (context) => WorkMonthEditPage(
        month: _copy,
      ),
    );

    result.modified<WorkMonth>((item) => _copy = item);
  }
}
