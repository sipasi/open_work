import 'package:open_work_flutter/data/summaries/summary_model.dart';

abstract class SummaryFor<T> {
  const SummaryFor();

  SummaryModel create(T entity) {
    return SummaryModel(
      types: summarizeTypes(entity),
      works: summarizeWorks(entity),
    );
  }

  List<TypeInfo> summarizeTypes(T entity);
  List<WorkInfo> summarizeWorks(T entity);
}
