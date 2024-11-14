// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:open_work_flutter/data/models/work_day.dart';
import 'package:open_work_flutter/services/navigation/material_navigator.dart';
import 'package:open_work_flutter/view/work_day/edit/day_edit_page.dart';
import 'package:open_work_flutter/view/work_month/detail/cubit/work_month_detail_cubit.dart';
import 'package:open_work_flutter/view/work_month/detail/widgets/day_list_view.dart';
import 'package:open_work_flutter/view/work_month/edit/work_month_edit_page.dart';
import 'package:open_work_flutter/view/work_month/summary/month_summary_page.dart';

class WorkMonthDetailsPage extends StatelessWidget {
  final int id;
  final DateTime date;

  const WorkMonthDetailsPage({
    super.key,
    required this.id,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WorkMonthDetailCubit(
        monthStorage: GetIt.I.get(),
      )..loadAll(id),
      child: WorkMonthDetailsView(
        id: id,
        date: date,
      ),
    );
  }
}

class WorkMonthDetailsView extends StatelessWidget {
  static final DateFormat _dayFormat = DateFormat.MMMM();

  final int id;
  final DateTime date;

  const WorkMonthDetailsView({
    super.key,
    required this.id,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_dayFormat.format(date)),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_document),
            onPressed: () => onEditTap(context),
          ),
        ],
      ),
      body: BlocBuilder<WorkMonthDetailCubit, WorkMonthDetailState>(
        builder: (context, state) {
          return DayListView(
            days: state.days,
            onTap: (day) => onDayTap(context, day),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Summarize'),
        onPressed: () => onSummarizeTap(context),
      ),
    );
  }

  Future onDayTap(BuildContext context, WorkDay day) async {
    final bloc = context.read<WorkMonthDetailCubit>();

    await MaterialNavigator.push(
      context,
      (context) => DayEditPage(month: bloc.state.month, day: day),
    );

    await bloc.loadAll(id);
  }

  Future onSummarizeTap(BuildContext context) async {
    final bloc = context.read<WorkMonthDetailCubit>();

    await MaterialNavigator.push(
      context,
      (context) => MonthSummaryPage(month: bloc.state.month),
    );

    await bloc.loadAll(id);
  }

  Future onEditTap(BuildContext context) async {
    final bloc = context.read<WorkMonthDetailCubit>();

    await MaterialNavigator.push(
      context,
      (context) => WorkMonthEditPage(month: bloc.state.month),
    );

    await bloc.loadAll(id);
  }
}
