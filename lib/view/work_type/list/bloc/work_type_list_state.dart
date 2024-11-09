part of 'work_type_list_bloc.dart';

enum WorkTypeListStatus { initial, loading, success, failure }

final class WorkTypeListState {
  final WorkTypeListStatus status;
  final List<WorkType> types;

  WorkTypeListState({
    this.status = WorkTypeListStatus.initial,
    this.types = const [],
  });

  WorkTypeListState copyWith({
    WorkTypeListStatus? status,
    List<WorkType>? types,
  }) {
    return WorkTypeListState(
      status: status ?? this.status,
      types: types ?? this.types,
    );
  }
}
