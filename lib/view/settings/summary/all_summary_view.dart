import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/data/summaries/month_list_summary.dart';
import 'package:open_work_flutter/data/summaries/summary_for.dart';
import 'package:open_work_flutter/data/summaries/summary_model.dart';
import 'package:open_work_flutter/theme/theme_extension.dart';
import 'package:open_work_flutter/view/settings/summary/cubit/settings_summary_cubit.dart';
import 'package:open_work_flutter/view/shared/work_summary/summary_view.dart';

class AllSummaryPage extends StatelessWidget {
  final SummaryFor<List<WorkMonth>> summary;

  const AllSummaryPage({
    super.key,
    this.summary = const MonthListSummary(),
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsSummaryCubit(
        monthStorage: GetIt.I.get(),
        summary: summary,
      )..load(),
      child: AllSummaryView(),
    );
  }
}

class AllSummaryView extends StatelessWidget {
  const AllSummaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Summary'),
      ),
      body: SafeArea(
        child: BlocBuilder<SettingsSummaryCubit, SettingsSummaryState>(
          builder: (context, state) {
            SummaryModel model = state.model;

            if (model.types.isEmpty && model.works.isEmpty) {
              return Center(
                child: Text(
                  'Have nothing to summary',
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.primary,
                  ),
                ),
              );
            }

            return SingleChildScrollView(
              child: SummaryView(
                summary: model,
              ),
            );
          },
        ),
      ),
    );
  }
}
