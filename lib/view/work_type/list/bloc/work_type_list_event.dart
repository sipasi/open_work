part of 'work_type_list_bloc.dart';

sealed class WorkTypeListEvent {}

final class WorkTypeListLoadRequested extends WorkTypeListEvent {}

final class WorkTypeListTypeDeleted extends WorkTypeListEvent {
  final WorkType type;

  WorkTypeListTypeDeleted({required this.type});
}
