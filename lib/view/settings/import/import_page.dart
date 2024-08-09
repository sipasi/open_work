import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/view/settings/import/import_view_model.dart';
import 'package:open_work_flutter/view/shared/selectable/selectable_items_scaffold.dart';

import '../../shared/futures/wait_state.dart';

class ImportPage extends StatefulWidget {
  const ImportPage({super.key});

  @override
  State<ImportPage> createState() => _ImportPageState();
}

class _ImportPageState extends WaitState<ImportPage> {
  final viewmodel = ImportViewModel(GetIt.I.get());

  @override
  Future getFuture() {
    return viewmodel.load();
  }

  @override
  Widget loading(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const LinearProgressIndicator(),
          Expanded(
              child: Center(
                  child: Text('Wait for file ...',
                      style: _getLargeText(context)))),
        ],
      ),
    );
  }

  @override
  Widget success(BuildContext context) {
    return viewmodel.selectable.items.isEmpty
        ? _empty(context)
        : _list(context);
  }

  Widget _empty(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('empty or wrong', style: _getLargeText(context)),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          loadFuture();

          setState(() {});
        },
        icon: const Icon(Icons.folder_outlined),
        label: const Text('select'),
      ),
    );
  }

  Widget _list(BuildContext context) {
    return SelectableItemsScaffold<WorkMonth>(
      titleBuilder: (item) => Text('${item.date.year}-${item.date.month}'),
      count: viewmodel.selectable.items.length,
      allSelected: viewmodel.selectable.allSelected,
      onSelectAll: () => setState(() => viewmodel.selectable.onSelectAll()),
      itemAt: viewmodel.selectable.at,
      selectedAt: viewmodel.selectable.selectedAt,
      fab: viewmodel.selectable.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () => viewmodel.onImport(context),
              icon: const Icon(Icons.import_export),
              label: const Text('Import'),
            )
          : null,
      onTap: (contains, index) =>
          setState(() => viewmodel.selectable.onTileTap(contains, index)),
    );
  }

  TextStyle? _getLargeText(BuildContext context) {
    return Theme.of(context).textTheme.headlineLarge?.copyWith(
          fontWeight: FontWeight.bold,
        );
  }
}