part of 'settings_import_bloc.dart';

enum FilesWaitingStatus {
  waiting,
  success,
}

enum ImportStatus {
  none,
  imported,
}

enum MonthExistBehavior {
  skip,
  overwrite,
}

enum WorkTypeBehavior {
  skip,
  addToStorage,
}

class MonthImportModel {
  final WorkMonth month;
  final bool exist;

  MonthImportModel({required this.month, required this.exist});

  MonthImportModel copyWith({bool? alredyExist}) {
    return MonthImportModel(
      month: month,
      exist: alredyExist ?? exist,
    );
  }
}

final class SettingsImportState {
  final FilesWaitingStatus filesWaitingState;
  final ImportStatus importStatus;
  final MonthExistBehavior existBehavior;
  final WorkTypeBehavior workTypeBehavior;

  final SelectablesModel<MonthImportModel> selectables;

  bool get waitingFiles => filesWaitingState == FilesWaitingStatus.waiting;
  bool get importedSuccessful => importStatus == ImportStatus.imported;
  bool get overwriteExisted => existBehavior == MonthExistBehavior.overwrite;
  bool get addTypesToStorage =>
      workTypeBehavior == WorkTypeBehavior.addToStorage;
  bool get existedSkip => existBehavior == MonthExistBehavior.skip;
  bool get anyExistedInSelected =>
      selectables.getSelected().any((e) => e.exist);

  SettingsImportState({
    required this.filesWaitingState,
    required this.importStatus,
    required this.existBehavior,
    required this.workTypeBehavior,
    required this.selectables,
  });
  SettingsImportState.initial()
      : filesWaitingState = FilesWaitingStatus.waiting,
        importStatus = ImportStatus.none,
        existBehavior = MonthExistBehavior.skip,
        workTypeBehavior = WorkTypeBehavior.addToStorage,
        selectables = SelectablesModel<MonthImportModel>(
          items: [],
          copyWith: (item) => item.copyWith(),
        );

  SettingsImportState copyWith({
    FilesWaitingStatus? filesWaitingStatus,
    ImportStatus? importStatus,
    MonthExistBehavior? existBehavior,
    WorkTypeBehavior? workTypeBehavior,
    SelectablesModel<MonthImportModel>? selections,
  }) {
    return SettingsImportState(
      filesWaitingState: filesWaitingStatus ?? filesWaitingState,
      importStatus: importStatus ?? this.importStatus,
      existBehavior: existBehavior ?? this.existBehavior,
      workTypeBehavior: workTypeBehavior ?? this.workTypeBehavior,
      selectables: selections ?? selectables.copy(),
    );
  }
}
