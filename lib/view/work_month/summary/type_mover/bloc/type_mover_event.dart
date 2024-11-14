part of 'type_mover_bloc.dart';

sealed class TypeMoverEvent {
  const TypeMoverEvent();
}

final class TypeMoverMoveToTypeChanged extends TypeMoverEvent {
  final WorkType value;

  TypeMoverMoveToTypeChanged(this.value);
}

final class TypeMoverDateSelected extends TypeMoverEvent {
  final DateWrapper value;

  TypeMoverDateSelected(this.value);
}

final class TypeMoverMovePressed extends TypeMoverEvent {}
