part of 'work_month_edit_bloc.dart';

sealed class WorkMonthEditEvent {}

final class WorkMonthEditLoadRequested extends WorkMonthEditEvent {
  final int id;

  WorkMonthEditLoadRequested(this.id);
}

final class WorkMonthEditSaveRequested extends WorkMonthEditEvent {
  final int id;

  WorkMonthEditSaveRequested(this.id);
}

final class WorkMonthEditTamplatePressed extends WorkMonthEditEvent {
  final int index;

  WorkMonthEditTamplatePressed(this.index);
}

final class WorkMonthEditSupportedPressed extends WorkMonthEditEvent {
  final int index;

  WorkMonthEditSupportedPressed(this.index);
}

final class WorkMonthEditRemovedPressed extends WorkMonthEditEvent {
  final int index;

  WorkMonthEditRemovedPressed(this.index);
}
