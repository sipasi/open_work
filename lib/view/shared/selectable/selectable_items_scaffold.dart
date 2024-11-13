import 'package:flutter/material.dart';
import 'package:open_work_flutter/view/shared/selectable/selectable_items_model.dart';

import 'selectable_grid_view.dart';

class SelectableItemsScaffold<T> extends StatelessWidget {
  final int count;
  final bool allSelected;

  final Widget? fab;

  final void Function(int index) onSelect;
  final void Function() onSelectAll;

  final T Function(int index) itemAt;

  final bool Function(int index) selectedAt;

  final Widget Function(T item) titleBuilder;
  final Widget Function(T item)? subtitleBuilder;

  const SelectableItemsScaffold({
    super.key,
    this.fab,
    required this.count,
    required this.allSelected,
    required this.onSelectAll,
    required this.itemAt,
    required this.selectedAt,
    required this.onSelect,
    required this.titleBuilder,
    this.subtitleBuilder,
  });

  factory SelectableItemsScaffold.from({
    required SelectablesModel<T> model,
    required void Function(int index) onSelect,
    required void Function() onSelectAll,
    required Widget Function(T item) titleBuilder,
    Widget Function(T item)? subtitleBuilder,
    Widget? fab,
  }) {
    return SelectableItemsScaffold<T>(
      count: model.count,
      allSelected: model.allSelected,
      titleBuilder: titleBuilder,
      subtitleBuilder: subtitleBuilder,
      fab: fab,
      itemAt: model.at,
      selectedAt: model.selectedAt,
      onSelectAll: () {
        onSelectAll();
      },
      onSelect: (index) {
        onSelect(index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          allSelected
              ? IconButton(
                  onPressed: onSelectAll,
                  icon: const Icon(Icons.done),
                )
              : TextButton(
                  onPressed: onSelectAll,
                  child: const Text('select all'),
                )
        ],
      ),
      floatingActionButton: fab,
      body: SelectableGridView<T>(
        count: count,
        onSelect: onSelect,
        itemAt: itemAt,
        selectedAt: selectedAt,
        titleBuilder: titleBuilder,
        subtitleBuilder: subtitleBuilder,
      ),
    );
  }
}
