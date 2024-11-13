part of 'work_month_detail_cubit.dart';

final class WorkMonthDetailState {
  final WorkMonth month;

  DateTime get date => month.date;

  List<WorkDay> get days => month.days;

  List<WorkType> get types => month.types;

  WorkMonthDetailState({required this.month});
  WorkMonthDetailState.empty()
      : month = WorkMonth(
          date: DateTime.now(),
          days: [],
          types: [],
        );

  WorkMonthDetailState copyWith({WorkMonth? month}) {
    return WorkMonthDetailState(month: month ?? this.month.deepCopy());
  }
}
