import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/data/summaries/summary_for.dart';
import 'package:open_work_flutter/data/summaries/summary_model.dart';

import 'month_summary_extension.dart';
import 'types_summarizer.dart';
import 'works_summarizer.dart';

class MonthSummary extends SummaryFor<WorkMonth> {
  final TypesSummarizer typesSummarizer;
  final WorksSummarizer worksSummarizer;

  const MonthSummary({
    this.typesSummarizer = const TypesSummarizer(),
    this.worksSummarizer = const WorksSummarizer(),
  });

  @override
  List<TypeInfo> summarizeTypes(WorkMonth entity) {
    final works = entity.expandWorks();

    final types = typesSummarizer.summarize(works);

    for (var type in entity.types) {
      bool notFound = types.indexWhere((element) => element.type == type) == -1;

      if (notFound) {
        types.add(TypeInfo.empty(type: type));
      }
    }

    return types;
  }

  @override
  List<WorkInfo> summarizeWorks(WorkMonth entity) {
    return worksSummarizer.summarize(entity.days);
  }
}
