import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/data/summaries/month_list_summary.dart';
import 'package:open_work_flutter/data/summaries/summary_for.dart';
import 'package:open_work_flutter/data/summaries/summary_model.dart';
import 'package:open_work_flutter/services/navigation/material_navigator.dart';
import 'package:open_work_flutter/storage/month_storage.dart';
import 'package:open_work_flutter/theme/theme_extension.dart';
import 'package:open_work_flutter/view/shared/futures/future_view.dart';
import 'package:open_work_flutter/view/work_month/summary/summary_view.dart';

class AllSummaryView extends StatefulWidget {
  final SummaryFor<List<WorkMonth>> summary;

  const AllSummaryView({
    super.key,
    this.summary = const MonthListSummary(),
  });

  @override
  State<AllSummaryView> createState() => _AllSummaryViewState();
}

class _AllSummaryViewState extends State<AllSummaryView> {
  late final Future<SummaryModel> summaryFuture;

  @override
  void initState() {
    super.initState();

    summaryFuture = Future(() async {
      final storage = GetIt.I.get<MonthStorage>();

      final months = await storage.getAll();

      return widget.summary.create(months);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Summary'),
      ),
      body: SafeArea(
        child: FutureView(
          future: summaryFuture,
          success: (context, snapshot) {
            if (snapshot.data == null) {
              MaterialNavigator.pop(context);

              return Container();
            }

            SummaryModel summary = snapshot.data!;

            if (summary.types.isEmpty && summary.works.isEmpty) {
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

            return SingleChildScrollView(child: SummaryView(summary: summary));
          },
        ),
      ),
    );
  }
}
