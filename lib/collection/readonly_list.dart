abstract class IReadonlyList<T> with Iterable<T> {
  const IReadonlyList();

  T operator [](int index);
}

class ReadonlyList<T> extends IReadonlyList<T> {
  final List<T> _list;

  const ReadonlyList(this._list);

  @override
  int get length => _list.length;

  @override
  T operator [](int index) => _list[index];

  @override
  Iterator<T> get iterator => _list.iterator;
}
