import 'package:open_work_flutter/collection/linq_iterable.dart';
import 'package:open_work_flutter/data/models/work_day.dart';
import 'package:open_work_flutter/data/models/work_type.dart';
import 'package:open_work_flutter/data/summaries/summary_model.dart';

class WorksSummarizer {
  const WorksSummarizer();

  List<WorkInfo> summarize(List<WorkDay> days) {
    final daysMap = days
        .map((day) => (
              day: day.date,
              typeUnitsPairMap: day.works
                  .groupBy((work) => work.type)
                  .entries
                  .map((group) => (
                        type: group.key,
                        units: group.value.expand((element) => element.units),
                      ))
                  .toList(),
            ))
        .toList();

    final map = <WorkType, Map<String, UnitDaysPairs>>{};

    for (final dayPair in daysMap) {
      for (final typeUnit in dayPair.typeUnitsPairMap) {
        if (map.containsKey(typeUnit.type) == false) {
          map[typeUnit.type] = {};
        }

        final valueSummaryMap = map[typeUnit.type]!;

        for (var unit in typeUnit.units) {
          final value = unit.value;

          if (valueSummaryMap.containsKey(value) == false) {
            valueSummaryMap[value] = UnitDaysPairs(unit, []);
          }

          final item = valueSummaryMap[value]!;

          item.dates.add(dayPair.day);
        }
      }
    }

    final infos = map.entries.map((e) {
      return WorkInfo(
        e.key,
        e.value.entries.map((e) => e.value).toList()..sort(compareIgnoreCase),
      );
    });

    return infos.toList();
  }

  static int compareIgnoreCase(UnitDaysPairs left, UnitDaysPairs right) {
    final leftLower = left.unit.value.toLowerCase();
    final rightLower = right.unit.value.toLowerCase();

    return leftLower.compareTo(rightLower);
  }
}
