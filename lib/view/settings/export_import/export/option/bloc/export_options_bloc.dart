import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/services/export/export_format.dart';
import 'package:open_work_flutter/services/export/path_factory/folder_location.dart';

part 'export_options_event.dart';
part 'export_options_state.dart';

class ExportOptionsBloc extends Bloc<ExportOptionsEvent, ExportOptionsState> {
  ExportOptionsBloc({
    required List<WorkMonth> months,
  }) : super(ExportOptionsState.initial(months)) {
    on<ExportOptionsExportQuantityChanged>((event, emit) {
      emit(
        state.copyWith(exportQuantity: event.value),
      );
    });

    on<ExportOptionsNameChanged>((event, emit) {
      emit(
        state.copyWith(fileName: event.value),
      );
    });
    on<ExportOptionsExportFormatChanged>((event, emit) {
      emit(
        state.copyWith(exportFormat: event.value),
      );
    });
    on<ExportOptionsExportMethodChanged>((event, emit) {
      emit(
        state.copyWith(exportMethod: event.value),
      );
    });
    on<ExportOptionsFolderLocationChanged>((event, emit) {
      emit(
        state.copyWith(folderLocation: event.value),
      );
    });
    on<ExportOptionsPerformRequested>((event, emit) {
      emit(state.copyWith(
        status: ExportStatus.readyToExport,
      ));
    });
  }
}
