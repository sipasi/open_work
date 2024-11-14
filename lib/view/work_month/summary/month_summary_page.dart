import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/data/models/work_type.dart';
import 'package:open_work_flutter/services/navigation/material_navigator.dart';
import 'package:open_work_flutter/view/shared/work_summary/summary_view.dart';
import 'package:open_work_flutter/view/work_month/summary/bloc/work_month_summary_bloc.dart';
import 'package:open_work_flutter/view/work_month/summary/type_mover/type_mover_view.dart';

class MonthSummaryPage extends StatelessWidget {
  final WorkMonth month;
  const MonthSummaryPage({
    super.key,
    required this.month,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WorkMonthSummaryBloc(monthStorage: GetIt.I.get())
        ..add(WorkMonthSummaryLoadRequested(
          monthId: month.id!,
        )),
      child: MonthSummaryView(
        monthId: month.id!,
        date: month.date,
        supportedTypes: month.types.toList(),
      ),
    );
  }
}

class MonthSummaryView extends StatelessWidget {
  final DateFormat _monthFormat = DateFormat.MMMM();

  final int monthId;
  final DateTime date;
  final List<WorkType> supportedTypes;

  MonthSummaryView({
    super.key,
    required this.monthId,
    required this.date,
    required this.supportedTypes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_monthFormat.format(date)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<WorkMonthSummaryBloc, WorkMonthSummaryState>(
            builder: (context, state) {
              return SummaryView(
                summary: state.model,
                onUnitDaysPairTap: (info, pairs) async {
                  await MaterialNavigator.push(
                    context,
                    (context) => TypeMoverPage(
                      monthId: monthId,
                      info: info,
                      pairs: pairs,
                      supportedTypes: supportedTypes,
                    ),
                  );

                  if (context.mounted) {
                    _bloc(context).add(WorkMonthSummaryLoadRequested(
                      monthId: monthId,
                    ));
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }

  WorkMonthSummaryBloc _bloc(BuildContext context) => context.read();
}
