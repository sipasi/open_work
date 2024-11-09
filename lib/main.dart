import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_work_flutter/services/dependency/dependency_setter.dart';
import 'package:open_work_flutter/theme/app_theme.dart';
import 'package:open_work_flutter/theme/theme_storage.dart';
import 'package:open_work_flutter/theme/theme_switcher.dart';
import 'package:open_work_flutter/theme/theme_switcher_widget.dart';
import 'package:open_work_flutter/view/home/cubit/home_cubit.dart';
import 'package:open_work_flutter/view/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppDependencySetter.set();

  await ThemeStorage.init();

  AppTheme theme = ThemeStorage.get();

  runApp(ThemeSwitcherWidget(
    initialTheme: theme,
    child: const OpenWorkApp(),
  ));
}

class OpenWorkApp extends StatelessWidget {
  const OpenWorkApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppTheme theme = ThemeSwitcher.of(context).theme!;

    return MaterialApp(
      title: 'Open Work',
      debugShowCheckedModeBanner: false,
      themeMode: theme.mode,
      theme: theme.asLight(),
      darkTheme: theme.asDark(),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HomeCubit()),
        ],
        child: const HomePage(),
      ),
    );
  }
}
