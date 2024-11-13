part of 'work_month_list_bloc.dart';

sealed class WorkMonthListEvent {}

final class WorkMonthListLoadRequested extends WorkMonthListEvent {}

final class WorkMonthListDeleteRequested extends WorkMonthListEvent {
  final int year;
  final int month;

  WorkMonthListDeleteRequested({required this.year, required this.month});
}

final class WorkMonthListCreateRequested extends WorkMonthListEvent {
  final int year;
  final int month;

  WorkMonthListCreateRequested({required this.year, required this.month});
}
