part of 'settings_export_bloc.dart';

class SettingsExportState {
  final SelectablesModel<WorkMonth> selectables;

  const SettingsExportState({required this.selectables});

  SettingsExportState.initial()
      : selectables = SelectablesModel<WorkMonth>(
          items: const [],
        );

  SettingsExportState copyWith({
    SelectablesModel<WorkMonth>? selectables,
  }) {
    return SettingsExportState(
      selectables: selectables ?? this.selectables.copy(),
    );
  }
}
