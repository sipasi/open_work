import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_work_flutter/data/models/work_type.dart';
import 'package:open_work_flutter/storage/type_storage.dart';

part 'work_type_list_event.dart';
part 'work_type_list_state.dart';

class WorkTypeListBloc extends Bloc<WorkTypeListEvent, WorkTypeListState> {
  WorkTypeListBloc(TypeStorage storage) : super(WorkTypeListState()) {
    on<WorkTypeListLoadRequested>((event, emit) async {
      emit(state.copyWith(
        status: WorkTypeListStatus.loading,
      ));

      final types = await storage.getAll();

      emit(state.copyWith(
        status: WorkTypeListStatus.loading,
        types: types,
      ));
    });
  }
}
