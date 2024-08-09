import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_work_flutter/view/shared/layouts/adaptive_grid_view.dart';

import 'month_info_tile.dart';
import 'work_month_details.dart';
import 'work_month_list_view_model.dart';

class WorkMonthListPage extends StatefulWidget {
  const WorkMonthListPage({super.key});

  @override
  State<WorkMonthListPage> createState() => _WorkMonthListPageState();
}

class _WorkMonthListPageState extends State<WorkMonthListPage> {
  late final WorkMonthListViewModel viewmodel;

  @override
  void initState() {
    super.initState();

    viewmodel = WorkMonthListViewModel(
      typeStorage: GetIt.I.get(),
      monthStorage: GetIt.I.get(),
      stateSetter: () {
        if (mounted) setState(() {});
      },
    );

    viewmodel.loadAll().then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final months = viewmodel.entities;

    return Scaffold(
      body: AdaptiveGridView(
        padding: const EdgeInsets.symmetric(horizontal: 10)
            .copyWith(top: 10, bottom: 80),
        children: List.generate(
          months.length,
          (index) {
            final month = months[index];

            return MonthInfoTile(
              month: WorkMonthDetails.from(month),
              onTap: () => viewmodel
                  .onTap(context, index)
                  .then((value) => setState(() {})),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => viewmodel.onCreateTap(context)),
    );
  }
}
