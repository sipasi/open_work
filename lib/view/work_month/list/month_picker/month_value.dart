class MonthValue {
  final int index;
  final int value;

  bool _selected = false;

  bool get selected => _selected;

  MonthValue(this.index) : value = index + 1;

  void set({required bool selected}) => _selected = selected;
  void select() => _selected = true;
  void unselect() => _selected = false;

  DateTime asDateTime({required int year}) => DateTime(year, value);
}
