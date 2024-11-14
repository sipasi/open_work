import 'package:open_work_flutter/collection/extension/linq_iterable.dart';
import 'package:open_work_flutter/data/calculations/work_calculator.dart';
import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/data/summaries/calculations_summarizer.dart';
import 'package:open_work_flutter/data/summaries/summary_for.dart';
import 'package:open_work_flutter/data/summaries/summary_model.dart';

import 'month_summary_extension.dart';
import 'types_summarizer.dart';
import 'works_summarizer.dart';

class MonthListSummary extends SummaryFor<List<WorkMonth>> {
  final CalculationsSummarizer calculationsSummarizer;
  final TypesSummarizer typesSummarizer;
  final WorksSummarizer worksSummarizer;

  const MonthListSummary({
    this.calculationsSummarizer = const CalculationsSummarizer(),
    this.typesSummarizer = const TypesSummarizer(),
    this.worksSummarizer = const WorksSummarizer(),
  });

  @override
  double summarizeTotal(List<WorkMonth> entity) {
    return entity
        .sumBy((element) => element.days
            .sumBy((element) => WorkCalculator.many(element.works))
            .toDouble())
        .toDouble();
  }

  @override
  List<CalculationInfo> summarizeCalculations(List<WorkMonth> entity) {
    final works = entity.expand((e) => e.expandWorks()).toList();

    return calculationsSummarizer.summarize(works);
  }

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
