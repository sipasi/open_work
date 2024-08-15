import 'work_old.dart';

class WorkDayOld {
  final DateTime date;

  final List<WorkOld> works;

  const WorkDayOld({
    required this.date,
    required this.works,
  });

  factory WorkDayOld.fromJson(Map<String, dynamic> json) => WorkDayOld(
        date: DateTime.parse(json['date'] as String),
        works: (json['works'] as List<dynamic>)
            .map((e) => WorkOld.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'date': date.toIso8601String(),
        'works': works,
      };
}
