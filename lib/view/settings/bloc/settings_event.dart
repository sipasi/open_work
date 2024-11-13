part of 'settings_bloc.dart';

sealed class SettingsEvent {
  const SettingsEvent();
}

final class SettingsThemeModeChanged extends SettingsEvent {
  final ThemeMode value;

  SettingsThemeModeChanged(this.value);
}

final class SettingsThemeColorChanged extends SettingsEvent {
  final ColorSeed value;

  SettingsThemeColorChanged(this.value);
}
