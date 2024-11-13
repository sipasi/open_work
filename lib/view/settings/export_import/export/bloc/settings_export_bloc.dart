import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/storage/month_storage.dart';
import 'package:open_work_flutter/view/shared/selectable/selectable_items_model.dart';

part 'settings_export_event.dart';
part 'settings_export_state.dart';

class SettingsExportBloc
    extends Bloc<SettingsExportEvent, SettingsExportState> {
  SettingsExportBloc({required MonthStorage monthStorage})
      : super(SettingsExportState.initial()) {
    on<SettingsExportLoadRequested>((event, emit) async {
      final months = await monthStorage.getAll();

      months.sort(
        (a, b) => b.date.compareTo(a.date),
      );

      emit(state.copyWith(
        selectables: SelectablesModel<WorkMonth>(items: months),
      ));
    });
    on<SettingsExportSelectAllPressed>((event, emit) {
      emit(
        state.copyWith()..selectables.selectAll(),
      );
    });
    on<SettingsExportSelectPressed>((event, emit) {
      emit(
        state.copyWith()..selectables.select(event.index),
      );
    });
  }
}
