import 'package:open_work_flutter/data/summaries/summary_model.dart';

abstract class SummaryFor<T> {
  const SummaryFor();

  SummaryModel create(T entity) {
    return SummaryModel(
      total: summarizeTotal(entity),
      calculations: summarizeCalculations(entity),
      types: summarizeTypes(entity),
      works: summarizeWorks(entity),
    );
  }

  double summarizeTotal(T entity);
  List<CalculationInfo> summarizeCalculations(T entity);
  List<TypeInfo> summarizeTypes(T entity);
  List<WorkInfo> summarizeWorks(T entity);
}
