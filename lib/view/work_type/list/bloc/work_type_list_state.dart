part of 'work_type_list_bloc.dart';

final class WorkTypeListState {
  final List<WorkType> types;

  WorkTypeListState({this.types = const []});

  WorkTypeListState copyWith({List<WorkType>? types}) {
    return WorkTypeListState(types: types ?? this.types);
  }
}
