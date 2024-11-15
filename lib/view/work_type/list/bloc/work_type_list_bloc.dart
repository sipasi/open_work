import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_work_flutter/data/models/work_type.dart';
import 'package:open_work_flutter/storage/type_storage.dart';

part 'work_type_list_event.dart';
part 'work_type_list_state.dart';

class WorkTypeListBloc extends Bloc<WorkTypeListEvent, WorkTypeListState> {
  WorkTypeListBloc({required TypeStorage typeStorage})
      : super(WorkTypeListState()) {
    on<WorkTypeListLoadRequested>((event, emit) async {
      emit(state.copyWith());

      final types = await typeStorage.getAll();

      emit(state.copyWith(types: types));
    });
  }
}
