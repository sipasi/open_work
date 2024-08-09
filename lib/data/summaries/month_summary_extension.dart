import 'package:open_work_flutter/data/models/work.dart';
import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/data/summaries/month_summary.dart';
import 'package:open_work_flutter/data/summaries/summary_model.dart';

extension MonthSummaryExtension on WorkMonth {
  SummaryModel summarize() => const MonthSummary().create(this);
  List<TypeInfo> summarizeTypes() => const MonthSummary().summarizeTypes(this);

  List<Work> expandWorks() => days.expand((e) => e.works).toList();
}
