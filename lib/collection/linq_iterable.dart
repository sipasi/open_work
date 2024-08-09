extension LinqIterable<T> on Iterable<T> {
  num sumBy(num Function(T element) selector) {
    num sum = 0;

    for (var element in this) {
      sum += selector(element);
    }

    return sum;
  }

  Map<Key, List<T>> groupBy<Key>(Key Function(T item) ketSelector) {
    var map = <Key, List<T>>{};

    for (var element in this) {
      final key = ketSelector(element);

      (map[key] ??= []).add(element);
    }

    return map;
  }
}

extension LinqNumIterable on Iterable<num> {
  num sum() {
    return sumBy((element) => element);
  }

  double sumDouble() {
    return sum().toDouble();
  }
}
