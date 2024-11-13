part of 'settings_export_bloc.dart';

sealed class SettingsExportEvent {
  const SettingsExportEvent();
}

final class SettingsExportLoadRequested extends SettingsExportEvent {}

final class SettingsExportSelectAllPressed extends SettingsExportEvent {}

final class SettingsExportSelectPressed extends SettingsExportEvent {
  final int index;

  SettingsExportSelectPressed(this.index);
}
