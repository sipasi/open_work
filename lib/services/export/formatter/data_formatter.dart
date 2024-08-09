import 'package:open_work_flutter/services/export/formatter/format_options.dart';

typedef Bytes = List<int>;

abstract class DataFormatter<T> {
  Future<Bytes> format(T data, FormatOptions options);
}
