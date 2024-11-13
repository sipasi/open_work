typedef CopyWithDelegate<T> = T Function(T item);

class SelectablesModel<T> {
  final Set<int> _selections;

  final List<T> _items;

  final CopyWithDelegate<T> _copyWith;

  int get selected => _selections.length;
  int get count => _items.length;

  bool get allSelected => _selections.length == _items.length;

  bool get selectionsNotEmpty => _selections.isNotEmpty;

  SelectablesModel({
    required List<T> items,
    CopyWithDelegate<T>? copyWith,
  })  : _items = items,
        _copyWith = copyWith ?? ((item) => item),
        _selections = {};
  SelectablesModel._(this._items, this._copyWith, this._selections);

  T at(int index) {
    return _items[index];
  }

  bool selectedAt(int index) {
    return _selections.contains(index);
  }

  List<T> getSelected() {
    return _selections.map(at).toList();
  }

  void select(int index) {
    bool added = _selections.add(index);

    if (added == false) _selections.remove(index);
  }

  void selectAll() {
    bool needSelectAll = allSelected == false;

    _selections.clear();

    if (needSelectAll) {
      _selections.addAll(List.generate(count, (index) => index));
    }
  }

  SelectablesModel<T> copy() {
    return SelectablesModel<T>._(
      _items.map(_copyWith).toList(),
      _copyWith,
      _selections.toSet(),
    );
  }
}
