import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_work_flutter/data/models/calculation_type.dart';
import 'package:open_work_flutter/data/models/work_type.dart';
import 'package:open_work_flutter/storage/type_storage.dart';

part 'work_type_edit_event.dart';
part 'work_type_edit_state.dart';

class WorkTypeEditBloc extends Bloc<WorkTypeEditEvent, WorkTypeEditState> {
  WorkTypeEditBloc({
    required TypeStorage typeStorage,
  }) : super(WorkTypeEditState.empty()) {
    on<WorkTypeEditInitRequested>((event, emit) {
      final type = event.workType;

      if (type == null) {
        return;
      }

      emit(
        state.copyWith(
          name: type.name,
          price: type.price.toString(),
          calculation: type.calculation,
        ),
      );
    });
    on<WorkTypeEditNameChanged>((event, emit) {
      emit(state.copyWith(name: event.value));
    });
    on<WorkTypeEditPriceChanged>((event, emit) {
      emit(state.copyWith(price: event.value));
    });
    on<WorkTypeEditCalculationChanged>((event, emit) {
      emit(state.copyWith(calculation: event.value));
    });
    on<WorkTypeEditSubmitRequested>((event, emit) async {
      final trimmedName = state.name.trim();

      if (trimmedName.isEmpty) {
        return;
      }

      double? price = double.tryParse(state.price);

      if (price == null) {
        return;
      }

      WorkType type = WorkType(
        id: event.id,
        name: trimmedName,
        price: price,
        calculation: state.calculation,
      );

      await typeStorage.updateOrCreate(type);

      emit(state.copyWith(storageStatus: WorkTypeStorageStatus.deleteOrSubmit));
    });
    on<WorkTypeEditDeleteRequested>((event, emit) async {
      final id = event.id;

      if (id == null) {
        return;
      }

      await typeStorage.delete(id);

      emit(state.copyWith(storageStatus: WorkTypeStorageStatus.deleteOrSubmit));
    });
  }
}
