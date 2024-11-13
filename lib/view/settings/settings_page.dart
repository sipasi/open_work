import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_work_flutter/services/navigation/material_navigator.dart';
import 'package:open_work_flutter/storage/month_storage.dart';
import 'package:open_work_flutter/storage/type_storage.dart';
import 'package:open_work_flutter/theme/color/color_seed.dart';
import 'package:open_work_flutter/theme/theme_extension.dart';
import 'package:open_work_flutter/theme/theme_storage.dart';
import 'package:open_work_flutter/theme/theme_switcher.dart';
import 'package:open_work_flutter/view/settings/bloc/settings_bloc.dart';
import 'package:open_work_flutter/view/settings/export_import/export/export_page.dart';
import 'package:open_work_flutter/view/settings/export_import/import/import_page.dart';
import 'package:open_work_flutter/view/settings/summary/all_summary_view.dart';
import 'package:open_work_flutter/view/settings/theme/theme_color_tile.dart';
import 'package:open_work_flutter/view/settings/theme/theme_mode_tile.dart';
import 'package:open_work_flutter/view/settings/theme/theme_tile_helper.dart';
import 'package:open_work_flutter/view/shared/dialogs/color_list_dialog.dart';
import 'package:open_work_flutter/view/shared/dialogs/delete_dialog.dart';
import 'package:open_work_flutter/view/shared/dialogs/waiting_dialog.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc(),
      child: SettingsView(),
    );
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 10.0),
      children: [
        BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return ThemeModeTile(
              mode: state.mode,
              onChanged: (value) => _onThemeModeChanged(context, value),
            );
          },
        ),
        BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return ThemeColorTile(
              seed: state.seed,
              onTap: () => _onThemeColorChanged(context, state.seed),
            );
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.file_download_outlined),
          title: OutlinedButton(
            child: const Text('Import'),
            onPressed: () => MaterialNavigator.push(
              context,
              (context) => const ImportPage(),
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.file_upload_outlined),
          title: OutlinedButton(
            child: const Text('Export'),
            onPressed: () => MaterialNavigator.push(
              context,
              (context) => const ExportPage(),
            ),
          ),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.summarize_outlined),
          title: OutlinedButton(
            child: const Text('Summarize All'),
            onPressed: () => MaterialNavigator.push(
              context,
              (context) => const AllSummaryPage(),
            ),
          ),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.delete_forever_outlined),
          title: OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: context.colorScheme.error,
            ),
            onPressed: () => _onDeleteAll(context),
            child: const Text('Delete all'),
          ),
        ),
      ],
    );
  }

  SettingsBloc _bloc(BuildContext context) {
    return context.read<SettingsBloc>();
  }

  Future _onThemeModeChanged(BuildContext context, ThemeMode next) async {
    final bloc = _bloc(context);

    ThemeTileHelper.setTheme(
      context: context,
      mode: next,
    );

    bloc.add(SettingsThemeModeChanged(next));
  }

  Future _onThemeColorChanged(BuildContext context, ColorSeed current) async {
    final value = await ColorListDialog.show(
      context: context,
      current: current,
    );

    if (value == null || value == current || context.mounted == false) {
      return;
    }

    final switcher = ThemeSwitcher.of(context);

    final newTheme = switcher.theme!.copyWith(seed: value);

    ThemeStorage.set(newTheme);

    ThemeTileHelper.setTheme(
      context: context,
      seed: value,
    );

    _bloc(context).add(SettingsThemeColorChanged(value));
  }

  Future _onDeleteAll(BuildContext context) async {
    bool result = await DeleteDialog.showMessage(
      context: context,
      message: 'This action delete all months and types',
    );

    if (result == false || context.mounted == false) {
      return;
    }

    await WaitingDialog.show(
      context: context,
      title: 'Deleting...',
      future: Future(() {
        final types = GetIt.I.get<TypeStorage>();
        final months = GetIt.I.get<MonthStorage>();

        return Future.wait([types.clear(), months.clear()]);
      }),
    );
  }
}
