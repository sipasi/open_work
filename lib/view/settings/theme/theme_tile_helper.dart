import 'package:flutter/material.dart';
import 'package:open_work_flutter/theme/app_theme.dart';
import 'package:open_work_flutter/theme/color/color_seed.dart';
import 'package:open_work_flutter/theme/theme_storage.dart';
import 'package:open_work_flutter/theme/theme_switcher.dart';

abstract class ThemeTileHelper {
  static void setTheme({
    required BuildContext context,
    ColorSeed? seed,
    ThemeMode? mode,
  }) {
    seed = seed ?? ThemeStorage.colorValue();
    mode = mode ?? ThemeStorage.modeValue();

    AppTheme theme = AppTheme(
      mode: mode,
      seed: seed,
    );

    ThemeSwitcher.of(context).switchTheme(theme);

    ThemeStorage.set(theme);
  }
}
