part of 'work_type_edit_bloc.dart';

sealed class WorkTypeEditEvent {}

final class WorkTypeEditInitRequested extends WorkTypeEditEvent {
  final WorkType? workType;

  WorkTypeEditInitRequested(this.workType);
}

final class WorkTypeEditNameChanged extends WorkTypeEditEvent {
  final String value;

  WorkTypeEditNameChanged(this.value);
}

final class WorkTypeEditPriceChanged extends WorkTypeEditEvent {
  final String value;

  WorkTypeEditPriceChanged(this.value);
}

final class WorkTypeEditCalculationChanged extends WorkTypeEditEvent {
  final CalculationType value;

  WorkTypeEditCalculationChanged(this.value);
}

final class WorkTypeEditSubmitRequested extends WorkTypeEditEvent {
  final int? id;

  WorkTypeEditSubmitRequested(this.id);
}

final class WorkTypeEditDeleteRequested extends WorkTypeEditEvent {
  final int? id;

  WorkTypeEditDeleteRequested(this.id);
}
