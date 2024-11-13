part of 'work_month_list_bloc.dart';

final class WorkMonthListState {
  final List<WorkMonth> months;

  WorkMonthListState({required this.months});
  WorkMonthListState.empty() : months = [];

  WorkMonthListState copyWith({List<WorkMonth>? months}) {
    return WorkMonthListState(months: months ?? this.months);
  }
}
