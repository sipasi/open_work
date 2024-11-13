part of 'work_month_summary_bloc.dart';

final class WorkMonthSummaryState {
  final SummaryModel model;

  double get total => model.total;
  List<CalculationInfo> get calculations => model.calculations;
  List<TypeInfo> get types => model.types;
  List<WorkInfo> get works => model.works;

  const WorkMonthSummaryState(this.model);

  const WorkMonthSummaryState.empty() : this(const SummaryModel.empty());

  WorkMonthSummaryState copy(SummaryModel model) {
    return WorkMonthSummaryState(model.copyWith());
  }
}
