import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/services/navigation/material_navigator.dart';
import 'package:open_work_flutter/view/settings/export_import/export/bloc/settings_export_bloc.dart';
import 'package:open_work_flutter/view/settings/export_import/export/option/export_options_page.dart';
import 'package:open_work_flutter/view/shared/selectable/selectable_items_scaffold.dart';

class ExportPage extends StatelessWidget {
  const ExportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsExportBloc(
        monthStorage: GetIt.I.get(),
      )..add(SettingsExportLoadRequested()),
      child: ExportView(),
    );
  }
}

class ExportView extends StatelessWidget {
  const ExportView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsExportBloc, SettingsExportState>(
      builder: (context, state) {
        return SelectableItemsScaffold<WorkMonth>.from(
          model: state.selectables,
          titleBuilder: (item) => Text('${item.date.year}-${item.date.month}'),
          fab: state.selectables.selectionsNotEmpty
              ? FloatingActionButton.extended(
                  label: const Text('Next'),
                  icon: const Icon(Icons.navigate_next),
                  onPressed: () => MaterialNavigator.push(
                    context,
                    (context) => ExportOptionsPage(
                      months: state.selectables.getSelected(),
                    ),
                  ),
                )
              : null,
          onSelectAll: () => _bloc(context).add(
            SettingsExportSelectAllPressed(),
          ),
          onSelect: (index) => _bloc(context).add(
            SettingsExportSelectPressed(index),
          ),
        );
      },
    );
  }

  SettingsExportBloc _bloc(BuildContext context) => context.read();
}
