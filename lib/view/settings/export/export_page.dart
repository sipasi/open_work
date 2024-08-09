import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/view/settings/export/export_view_model.dart';
import 'package:open_work_flutter/view/shared/selectable/selectable_items_scaffold.dart';

import '../../shared/futures/wait_state.dart';

class ExportPage extends StatefulWidget {
  const ExportPage({super.key});

  @override
  State<ExportPage> createState() => _ExportPageState();
}

class _ExportPageState extends WaitState<ExportPage> {
  final viewmodel = ExportViewModel(GetIt.I.get());

  @override
  Future getFuture() {
    return viewmodel.load();
  }

  @override
  Widget success(BuildContext context) {
    return SelectableItemsScaffold<WorkMonth>(
      titleBuilder: (item) => Text('${item.date.year}-${item.date.month}'),
      count: viewmodel.selectable.items.length,
      allSelected: viewmodel.selectable.allSelected,
      onSelectAll: () => setState(() => viewmodel.selectable.onSelectAll()),
      itemAt: viewmodel.selectable.at,
      selectedAt: viewmodel.selectable.selectedAt,
      fab: viewmodel.canShare()
          ? FloatingActionButton.extended(
              label: const Text('Share'),
              icon: const Icon(Icons.share_outlined),
              onPressed: () => viewmodel.toExportDestination(context),
            )
          : null,
      onTap: (contains, index) {
        setState(() {
          viewmodel.selectable.onTileTap(contains, index);
        });
      },
    );
  }
}
