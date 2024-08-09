import 'package:open_work_flutter/collection/linq_iterable.dart';
import 'package:open_work_flutter/data/calculations/work_list_calculation_extension.dart';
import 'package:open_work_flutter/data/models/work.dart';
import 'package:open_work_flutter/data/summaries/summary_model.dart';

class TypesSummarizer {
  const TypesSummarizer();

  List<TypeInfo> summarize(List<Work> works) {
    final grouped = works.groupBy((item) => item.type);

    final infos = grouped.entries.map((entry) {
      return TypeInfo(
        type: entry.key,
        count: entry.value.unitsCount(),
        sum: entry.value.calculate(),
        units: List.unmodifiable(entry.value.expand((e) => e.units)),
      );
    });

    return infos.toList();
  }
}
