import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_work_flutter/theme/color/color_seed.dart';
import 'package:open_work_flutter/theme/theme_storage.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsState.initial()) {
    on<SettingsThemeColorChanged>((event, emit) {
      emit(SettingsState(
        mode: ThemeStorage.modeValue(),
        seed: event.value,
      ));
    });
    on<SettingsThemeModeChanged>((event, emit) {
      emit(SettingsState(
        mode: event.value,
        seed: ThemeStorage.colorValue(),
      ));
    });
  }
}
