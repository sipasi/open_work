class SelectableItemsModel<T> {
  final Set<int> _selections;

  final List<T> items;

  bool get allSelected => _selections.length == items.length;

  bool get isNotEmpty => _selections.isNotEmpty;

  int get selections => _selections.length;

  SelectableItemsModel(this.items) : _selections = {};

  List<T> getSelected() {
    final selected = _selections.map((index) => items[index]).toList();

    return selected;
  }

  void onTileTap(bool contains, int index) {
    if (contains) {
      _selections.remove(index);

      return;
    }
    _selections.add(index);
  }

  void onSelectAll() {
    if (allSelected) {
      _selections.clear();
      return;
    }

    _selections.clear();

    _selections.addAll(List.generate(items.length, (index) => index));
  }

  bool selectedAt(int index) {
    return _selections.contains(index);
  }

  T at(int index) {
    return items[index];
  }
}
