import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_work_flutter/storage/type_storage.dart';
import 'package:open_work_flutter/view/shared/layouts/adaptive_grid_view.dart';
import 'package:open_work_flutter/view/shared/tiles/stretched_tile.dart';

import 'work_type_list_view_model.dart';

class WorkTypeListPage extends StatefulWidget {
  const WorkTypeListPage({super.key});

  @override
  State<StatefulWidget> createState() => _WorkTypeListPageState();
}

class _WorkTypeListPageState extends State<WorkTypeListPage> {
  final viewmodel = WorkTypeListViewModel(GetIt.I.get<TypeStorage>());

  @override
  void initState() {
    super.initState();

    viewmodel.loadAll().then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AdaptiveGridView(
        padding: const EdgeInsets.all(10).copyWith(bottom: 75),
        children: List.generate(viewmodel.types.length, _tile),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await viewmodel.onAdd(context);

          if (mounted) setState(() {});
        },
      ),
    );
  }

  Widget _tile(int index) {
    final type = viewmodel.types[index];

    final theme = Theme.of(context);
    final scheem = theme.colorScheme;

    final titleStyle = theme.textTheme.bodyLarge?.copyWith(
      color: scheem.primary,
    );
    final subtitleStyle = theme.textTheme.bodySmall?.copyWith(
      color: Colors.green[400],
    );

    return Card.outlined(
      child: StretchedTile(
        title: Text(type.name, style: titleStyle),
        subtitle: Text(type.price.toString(), style: subtitleStyle),
        onTap: () async {
          await viewmodel.onTap(context, index);

          if (mounted) setState(() {});
        },
      ),
    );
  }
}
