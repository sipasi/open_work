part of 'settings_bloc.dart';

final class SettingsState {
  final ThemeMode mode;
  final ColorSeed seed;

  SettingsState({required this.mode, required this.seed});
  SettingsState.initial()
      : mode = ThemeStorage.modeValue(),
        seed = ThemeStorage.colorValue();
}
