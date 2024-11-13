part of 'work_month_summary_bloc.dart';

sealed class WorkMonthSummaryEvent {
  const WorkMonthSummaryEvent();
}

final class WorkMonthSummaryLoadRequested extends WorkMonthSummaryEvent {
  final int monthId;

  WorkMonthSummaryLoadRequested({required this.monthId});
}
