import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/data/summaries/summary_for.dart';
import 'package:open_work_flutter/data/summaries/summary_model.dart';

import 'month_summary_extension.dart';
import 'types_summarizer.dart';
import 'works_summarizer.dart';

class MonthListSummary extends SummaryFor<List<WorkMonth>> {
  final TypesSummarizer typesSummarizer;
  final WorksSummarizer worksSummarizer;

  const MonthListSummary({
    this.typesSummarizer = const TypesSummarizer(),
    this.worksSummarizer = const WorksSummarizer(),
  });

  @override
  List<TypeInfo> summarizeTypes(List<WorkMonth> entity) {
    final works = entity.expand((e) => e.expandWorks()).toList();

    final types = typesSummarizer.summarize(works);

    for (var month in entity) {
      for (var type in month.types) {
        bool notFound =
            types.indexWhere((element) => element.type == type) == -1;

        if (notFound) {
          types.add(TypeInfo.empty(type: type));
        }
      }
    }

    return types;
  }

  @override
  List<WorkInfo> summarizeWorks(List<WorkMonth> entity) {
    return worksSummarizer.summarize(entity.expand((e) => e.days).toList());
  }
}
