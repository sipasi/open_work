import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_work_flutter/collection/extension/list_sort.dart';
import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/storage/month_storage.dart';
import 'package:open_work_flutter/storage/type_storage.dart';
import 'package:open_work_flutter/view/settings/export_import/data/json/import_export_json.dart';
import 'package:open_work_flutter/view/shared/selectable/selectable_items_model.dart';

part 'settings_import_event.dart';
part 'settings_import_state.dart';

class SettingsImportBloc
    extends Bloc<SettingsImportEvent, SettingsImportState> {
  final MonthStorage monthStorage;
  final TypeStorage typeStorage;

  SettingsImportBloc({
    required this.monthStorage,
    required this.typeStorage,
  }) : super(SettingsImportState.initial()) {
    on<SettingsImportWaitFiles>((event, emit) {
      emit(state.copyWith(
        filesWaitingStatus: FilesWaitingStatus.waiting,
        importStatus: ImportStatus.none,
      ));
    });

    on<SettingsImportFilesPicked>(_onFilesPicked);

    on<SettingsImportSelectAllPressed>((event, emit) {
      emit(
        state.copyWith()..selectables.selectAll(),
      );
    });
    on<SettingsImportItemTap>((event, emit) {
      emit(
        state.copyWith()..selectables.select(event.index),
      );
    });
    on<SettingsImportMonthExistChanged>((event, emit) {
      emit(
        state.copyWith(existBehavior: event.value),
      );
    });
    on<SettingsImportWorkTypeChanged>((event, emit) {
      emit(
        state.copyWith(workTypeBehavior: event.value),
      );
    });

    on<SettingsImportRequested>(_onImportRequested);
  }

  FutureOr<void> _onFilesPicked(
    SettingsImportFilesPicked event,
    Emitter<SettingsImportState> emit,
  ) async {
    List<MonthImportModel> items = [];

    for (var file in event.files) {
      final bytes = await bytesFromPlatformFile(file);

      List<MonthImportModel> list = await bytesToMonthModel(bytes);

      list.sortDescBy((item) => item.month.date);

      items.addAll(list);
    }

    emit(state.copyWith(
      filesWaitingStatus: FilesWaitingStatus.success,
      selections: SelectablesModel<MonthImportModel>(
        items: items,
        copyWith: (item) => item.copyWith(),
      ),
    ));
  }

  Future<List<MonthImportModel>> bytesToMonthModel(Uint8List bytes) async {
    final text = utf8.decode(bytes);

    final futures = ImportExportJson.month.from(text).map((e) async {
      return MonthImportModel(
        month: e,
        exist: await monthStorage.containsMonth(e.date),
      );
    });

    final list = await Future.wait(futures);
    return list;
  }

  Future _onImportRequested(
    SettingsImportRequested event,
    Emitter<SettingsImportState> emit,
  ) async {
    final selected = state.selectables.getSelected();

    if (state.existedSkip) {
      selected.removeWhere((element) => element.exist);
    }

    await importMonths(monthStorage, selected);

    if (state.addTypesToStorage) {
      await importTypes(typeStorage, selected);
    }

    emit(state.copyWith(
      importStatus: ImportStatus.imported,
    ));
  }

  Future importMonths(MonthStorage storage, List<MonthImportModel> models) {
    final futures = models.map(
      (item) {
        return item.exist
            ? storage.updateOrCreateByDate(item.month)
            : storage.updateOrCreate(item.month);
      },
    );

    return Future.wait(futures);
  }

  Future importTypes(TypeStorage storage, List<MonthImportModel> models) async {
    final storageTypes = await storage.getAll();

    final uniqueImportedTypes = models.expand((e) => e.month.types).toSet();

    uniqueImportedTypes.removeWhere(storageTypes.contains);

    final futures = uniqueImportedTypes.map(storage.updateOrCreate);

    return Future.wait(futures);
  }

  Future<Uint8List> bytesFromPlatformFile(PlatformFile file) {
    if (kIsWeb) return Future.value(file.bytes ?? Uint8List(0));

    if (file.path == null) {
      return Future.value(Uint8List(0));
    }

    return File(file.path!).readAsBytes();
  }
}
