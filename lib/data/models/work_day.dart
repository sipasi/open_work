// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:open_work_flutter/data/models/work.dart';

part 'work_day.g.dart';

@JsonSerializable(explicitToJson: true)
class WorkDay {
  final DateTime date;

  final List<Work> works;

  const WorkDay({
    required this.date,
    required this.works,
  });

  factory WorkDay.fromJson(Map<String, dynamic> json) =>
      _$WorkDayFromJson(json);
  Map<String, dynamic> toJson() => _$WorkDayToJson(this);

  WorkDay copyWith({DateTime? date, List<Work>? works}) {
    return WorkDay(
      date: date ?? this.date,
      works: works ?? this.works,
    );
  }
}
