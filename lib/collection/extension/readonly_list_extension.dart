import 'package:open_work_flutter/collection/readonly_list.dart';

extension ReadonlyListExtension<T> on List<T> {
  ReadonlyList<T> asReadonly() => ReadonlyList(this);
}
