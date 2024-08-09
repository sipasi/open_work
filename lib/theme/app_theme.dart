import 'package:flutter/material.dart';
import 'package:open_work_flutter/theme/color/color_seed.dart';

class AppTheme {
  final ThemeMode mode;
  final ColorSeed seed;

  const AppTheme({
    required this.mode,
    required this.seed,
  });

  ThemeData asDark() => _create(Brightness.dark);
  ThemeData asLight() => _create(Brightness.light);

  ThemeData _create(Brightness brightness) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorSchemeSeed: seed.color,
    );

    // final color = data.colorScheme.surfaceContainer;

    // return data.copyWith(
    //   appBarTheme: AppBarTheme(
    //     systemOverlayStyle: SystemUiOverlayStyle(
    //       systemNavigationBarColor: color,
    //       statusBarColor: color,
    //     ),
    //   ),
    // );
  }

  AppTheme copyWith({
    ThemeMode? mode,
    ColorSeed? seed,
  }) =>
      AppTheme(mode: mode ?? this.mode, seed: seed ?? this.seed);
}
