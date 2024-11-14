import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_work_flutter/data/models/work_type.dart';
import 'package:open_work_flutter/view/shared/bloc/global_key_bloc_reader.dart';
import 'package:open_work_flutter/view/shared/layouts/adaptive_grid_view.dart';
import 'package:open_work_flutter/view/work_type/edit/type_edit_sheet.dart';
import 'package:open_work_flutter/view/work_type/list/bloc/work_type_list_bloc.dart';
import 'package:open_work_flutter/view/work_type/list/widgets/work_type_tile.dart';

class WorkTypeListPage extends StatelessWidget {
  // fix - Looking up a deactivated widget's ancestor is unsafe.
  // allow access to new BuildContext when change app orientation
  final GlobalKey _contextAccessKey = GlobalKey();

  WorkTypeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WorkTypeListView(contextAccessKey: _contextAccessKey);
  }
}

class WorkTypeListView extends StatelessWidget {
  const WorkTypeListView({required GlobalKey contextAccessKey})
      : super(key: contextAccessKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WorkTypeListBloc, WorkTypeListState>(
        builder: (context, state) {
          return AdaptiveGridView(
            padding: const EdgeInsets.all(10).copyWith(bottom: 75),
            children: List.generate(
              state.types.length,
              (index) => WorkTypeTile(
                type: state.types[index],
                onTap: () => _onEdit(context, state.types[index]),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _onCreate(context);
        },
      ),
    );
  }

  Future _onCreate(BuildContext context) async {
    await TypeEditSheet.create(context);

    final bloc = key.read<WorkTypeListBloc>();

    bloc?.add(WorkTypeListLoadRequested());
  }

  Future _onEdit(BuildContext context, WorkType type) async {
    await TypeEditSheet.edit(context, type);

    final bloc = key.read<WorkTypeListBloc>();

    bloc?.add(WorkTypeListLoadRequested());
  }
}
