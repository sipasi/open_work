import 'package:flutter/material.dart';
import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/data/summaries/month_summary.dart';
import 'package:open_work_flutter/data/summaries/summary_for.dart';
import 'package:open_work_flutter/data/summaries/summary_model.dart';

import 'summary_view.dart';

class MonthSummaryPage extends StatefulWidget {
  final WorkMonth month;
  final SummaryFor<WorkMonth> summary;

  const MonthSummaryPage({
    super.key,
    required this.month,
    this.summary = const MonthSummary(),
  });

  @override
  State<MonthSummaryPage> createState() => _MonthSummaryPageState();
}

class _MonthSummaryPageState extends State<MonthSummaryPage> {
  late final SummaryModel model;

  @override
  void initState() {
    super.initState();

    model = widget.summary.create(widget.month);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Summary'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SummaryView(summary: model),
        ),
      ),
    );
  }
}
