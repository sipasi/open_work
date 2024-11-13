part of 'settings_import_bloc.dart';

sealed class SettingsImportEvent {
  const SettingsImportEvent();
}

final class SettingsImportWaitFiles extends SettingsImportEvent {}

final class SettingsImportFilesPicked extends SettingsImportEvent {
  final List<File> files;

  SettingsImportFilesPicked(this.files);
}

final class SettingsImportSelectAllPressed extends SettingsImportEvent {}

final class SettingsImportItemTap extends SettingsImportEvent {
  final int index;

  SettingsImportItemTap({required this.index});
}

final class SettingsImportMonthExistChanged extends SettingsImportEvent {
  final MonthExistBehavior value;

  SettingsImportMonthExistChanged(this.value);
}

final class SettingsImportWorkTypeChanged extends SettingsImportEvent {
  final WorkTypeBehavior value;

  SettingsImportWorkTypeChanged(this.value);
}

final class SettingsImportRequested extends SettingsImportEvent {}
