import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_work_flutter/view/shared/bloc/global_key_bloc_reader.dart';
import 'package:open_work_flutter/view/shared/layouts/adaptive_grid_view.dart';
import 'package:open_work_flutter/view/work_month/detail/work_month_details_page.dart';
import 'package:open_work_flutter/view/work_month/list/bloc/work_month_list_bloc.dart';
import 'package:open_work_flutter/view/work_month/list/widgets/month_picker/month_picker.dart';

import 'widgets/month_info_tile.dart';
import 'work_month_details.dart';

class WorkMonthListPage extends StatelessWidget {
  // fix - Looking up a deactivated widget's ancestor is unsafe.
  // allow access to new BuildContext when change app orientation
  final GlobalKey _contextAccessKey = GlobalKey();

  WorkMonthListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WorkMonthListBloc(
        monthStorage: GetIt.I.get(),
        typeStorage: GetIt.I.get(),
      )..add(WorkMonthListLoadRequested()),
      child: WorkMonthListView(contextAccessKey: _contextAccessKey),
    );
  }
}

class WorkMonthListView extends StatelessWidget {
  const WorkMonthListView({required GlobalKey contextAccessKey})
      : super(key: contextAccessKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WorkMonthListBloc, WorkMonthListState>(
        builder: (context, state) {
          final months = state.months;

          return AdaptiveGridView(
            padding: const EdgeInsets.symmetric(horizontal: 10)
                .copyWith(top: 10, bottom: 80),
            children: List.generate(
              months.length,
              (index) {
                final month = months[index];

                return MonthInfoTile(
                  month: WorkMonthDetails.from(month),
                  onTap: () => _onTap(context, index),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add), onPressed: () => _onCreateTap(context)),
    );
  }

  Future _onTap(BuildContext context, int index) async {
    final month = context.read<WorkMonthListBloc>().state.months[index];

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WorkMonthDetailsPage(month: month),
      ),
    );

    key.read<WorkMonthListBloc>()?.add(WorkMonthListLoadRequested());
  }

  Future _onCreateTap(BuildContext context) async {
    var picker = MonthPicker(
      initialYear: DateTime.now().year,
      onYearChanged: (year, months) {
        months.unselectAll();

        final entities = context.read<WorkMonthListBloc>().state.months;

        if (entities.isEmpty) {
          return;
        }

        final similar = entities.where((element) => element.date.year == year);

        for (final element in similar) {
          final month = months.getBy(element.date.month);

          month.select();
        }
      },
      onMonthSelected: (year, month) {
        month.select();

        final a = key.read<WorkMonthListBloc>();

        a?.add(WorkMonthListCreateRequested(
          year: year,
          month: month.value,
        ));
      },
      onMonthDeleted: (year, month) {
        month.unselect();

        key.read<WorkMonthListBloc>()?.add(WorkMonthListDeleteRequested(
              year: year,
              month: month.value,
            ));
      },
    );

    if (context.mounted) {
      await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (builder) => picker,
      );
    }
  }
}
