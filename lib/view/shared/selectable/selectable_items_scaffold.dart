import 'package:flutter/material.dart';

import 'selectable_grid_view.dart';

class SelectableItemsScaffold<T> extends StatelessWidget {
  final int count;
  final bool allSelected;

  final void Function() onSelectAll;

  final T Function(int index) itemAt;

  final bool Function(int index) selectedAt;

  final void Function(bool contains, int index) onTap;

  final Widget Function(T item) titleBuilder;
  final Widget Function(T item)? subtitleBuilder;

  final Widget? fab;

  const SelectableItemsScaffold({
    super.key,
    this.fab,
    required this.count,
    required this.allSelected,
    required this.onSelectAll,
    required this.itemAt,
    required this.selectedAt,
    required this.onTap,
    required this.titleBuilder,
    this.subtitleBuilder,
  });

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
        onTap: onTap,
        itemAt: itemAt,
        selectedAt: selectedAt,
        titleBuilder: titleBuilder,
        subtitleBuilder: subtitleBuilder,
      ),
    );
  }
}
