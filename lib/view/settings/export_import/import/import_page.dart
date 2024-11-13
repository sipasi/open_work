import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_work_flutter/services/navigation/material_navigator.dart';
import 'package:open_work_flutter/theme/theme_extension.dart';
import 'package:open_work_flutter/view/settings/export_import/import/bloc/settings_import_bloc.dart';
import 'package:open_work_flutter/view/settings/export_import/import/widgets/import_warnings_view.dart';
import 'package:open_work_flutter/view/shared/selectable/selectable_items_scaffold.dart';

class ImportPage extends StatelessWidget {
  const ImportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsImportBloc(
        monthStorage: GetIt.I.get(),
        typeStorage: GetIt.I.get(),
      )..add(SettingsImportWaitFiles()),
      child: ImportView(),
    );
  }
}

class ImportView extends StatelessWidget {
  const ImportView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsImportBloc, SettingsImportState>(
      listener: (context, state) async {
        if (state.waitingFiles) {
          await _watingFilesListener(context);
        }

        if (state.importedSuccessful) {
          MaterialNavigator.pop(context);
        }
      },
      builder: (context, state) {
        if (state.waitingFiles) {
          return _waiting(context);
        }

        if (state.selectables.count == 0) {
          return _empty(context);
        }

        return _list(context, state);
      },
    );
  }

  Widget _empty(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('empty or wrong', style: _getLargeText(context)),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _bloc(context).add(
          SettingsImportWaitFiles(),
        ),
        icon: const Icon(Icons.folder_outlined),
        label: const Text('select'),
      ),
    );
  }

  Widget _waiting(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const LinearProgressIndicator(),
          Expanded(
            child: Center(
              child: Text(
                'Wait for file ...',
                style: _getLargeText(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _list(BuildContext context, SettingsImportState state) {
    return SelectableItemsScaffold<MonthImportModel>.from(
      model: state.selectables,
      titleBuilder: (item) {
        final date = item.month.date;

        return Text('${date.year}-${date.month}');
      },
      subtitleBuilder: (item) {
        return Text(item.exist ? 'alredy exist' : 'new');
      },
      fab: state.selectables.selectionsNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () => _onImportTap(context),
              icon: const Icon(Icons.import_export),
              label: const Text('Import'),
            )
          : null,
      onSelectAll: () => _bloc(context).add(
        SettingsImportSelectAllPressed(),
      ),
      onSelect: (index) => _bloc(context).add(
        SettingsImportItemTap(index: index),
      ),
    );
  }

  void _onImportTap(BuildContext context) async {
    final bloc = _bloc(context);

    final result = await ImportWarningsView.dialog(
      context: context,
      shouldOverwriteExisted: bloc.state.overwriteExisted,
      shouldAddTypesToStorage: bloc.state.addTypesToStorage,
    );

    if (result.cancel) {
      return;
    }

    bloc
      ..add(SettingsImportMonthExistChanged(result.shouldOverwriteExisted))
      ..add(SettingsImportWorkTypeChanged(result.shouldAddTypesToStorage))
      ..add(SettingsImportRequested());
  }

  Future<void> _watingFilesListener(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      dialogTitle: 'Select json files',
      allowedExtensions: ['json'],
    );

    final files = result?.paths.map((path) => File(path!)).toList();

    _bloc(context).add(SettingsImportFilesPicked(files ?? []));
  }

  TextStyle? _getLargeText(BuildContext context) {
    return context.textTheme.headlineLarge?.copyWith(
      fontWeight: FontWeight.bold,
    );
  }

  SettingsImportBloc _bloc(BuildContext context) => context.read();
}
