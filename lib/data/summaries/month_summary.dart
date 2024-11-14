import 'package:open_work_flutter/collection/extension/linq_iterable.dart';
import 'package:open_work_flutter/data/calculations/work_calculator.dart';
import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/data/summaries/calculations_summarizer.dart';
import 'package:open_work_flutter/data/summaries/summary_for.dart';
import 'package:open_work_flutter/data/summaries/summary_model.dart';

import 'month_summary_extension.dart';
import 'types_summarizer.dart';
import 'works_summarizer.dart';

class MonthSummary extends SummaryFor<WorkMonth> {
  final CalculationsSummarizer calculationsSummarizer;
  final TypesSummarizer typesSummarizer;
  final WorksSummarizer worksSummarizer;

  const MonthSummary({
    this.calculationsSummarizer = const CalculationsSummarizer(),
    this.typesSummarizer = const TypesSummarizer(),
    this.worksSummarizer = const WorksSummarizer(),
  });

  @override
  double summarizeTotal(WorkMonth entity) {
    return entity.days
        .sumBy((element) => WorkCalculator.many(element.works))
        .toDouble();
  }

  @override
  List<CalculationInfo> summarizeCalculations(WorkMonth entity) {
    final works = entity.expandWorks();

    return calculationsSummarizer.summarize(works);
  }

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
