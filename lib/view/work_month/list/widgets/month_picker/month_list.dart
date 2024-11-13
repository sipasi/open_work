import 'month_value.dart';

class MonthList {
  static const int count = 12;

  final List<MonthValue> _list = List.generate(
    count,
    growable: false,
    (index) => MonthValue(index),
  );

  int get length => _list.length;
  int get monthCount => count;

  MonthValue operator [](int index) => _list[index];

  MonthValue getBy(int month) {
    if (month > count || month < 1) {
      throw 'Selected month [$month] out of range. $month > $count || $month < 1';
    }

    return _list[month - 1];
  }

  void unselectAll() {
    for (var element in _list) {
      element.unselect();
    }
  }
}
