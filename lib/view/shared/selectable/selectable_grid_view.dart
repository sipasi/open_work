import 'package:flutter/material.dart';
import 'package:open_work_flutter/view/shared/layouts/adaptive_grid_view.dart';

class SelectableGridView<T> extends StatelessWidget {
  final int count;

  final T Function(int index) itemAt;

  final bool Function(int index) selectedAt;

  final void Function(bool contains, int index) onTap;

  final Widget Function(T item) titleBuilder;
  final Widget Function(T item)? subtitleBuilder;

  const SelectableGridView({
    super.key,
    required this.count,
    required this.onTap,
    required this.itemAt,
    required this.selectedAt,
    required this.titleBuilder,
    required this.subtitleBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return AdaptiveGridView(
      children: List.generate(
        count,
        (index) => _tile(index),
      ),
    );
  }

  Widget _tile(int index) {
    final entity = itemAt(index);

    bool contains = selectedAt(index);

    return ListTile(
      title: titleBuilder(entity),
      subtitle: subtitleBuilder?.call(entity),
      trailing: Icon(Icons.circle, color: contains ? null : Colors.transparent),
      titleAlignment: ListTileTitleAlignment.top,
      selected: contains,
      onTap: () => onTap(contains, index),
    );
  }
}
