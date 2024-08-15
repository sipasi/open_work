import 'work_day_old.dart';

class WorkMonthOld {
  final String id;

  final DateTime date;

  final List<WorkDayOld> days;

  const WorkMonthOld({
    required this.id,
    required this.date,
    required this.days,
  });

  factory WorkMonthOld.fromJson(Map<String, dynamic> json) => WorkMonthOld(
        id: json['id'] as String,
        date: DateTime.parse(json['date'] as String),
        days: (json['days'] as List<dynamic>)
            .map((e) => WorkDayOld.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'date': date.toIso8601String(),
        'days': days,
      };
}
