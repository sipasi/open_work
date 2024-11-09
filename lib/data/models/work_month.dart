import 'package:json_annotation/json_annotation.dart';
import 'package:open_work_flutter/data/models/work_day.dart';
import 'package:open_work_flutter/data/models/work_type.dart';

part 'work_month.g.dart';

@JsonSerializable(explicitToJson: true)
class WorkMonth {
  final int? id;

  final DateTime date;

  final List<WorkDay> days;

  final List<WorkType> types;

  const WorkMonth({
    this.id,
    required this.date,
    required this.days,
    required this.types,
  });
  factory WorkMonth.fromJson(Map<String, dynamic> json) =>
      _$WorkMonthFromJson(json);
  Map<String, dynamic> toJson() => _$WorkMonthToJson(this);

  WorkMonth copyWith({
    int? id,
    DateTime? date,
    List<WorkDay>? days,
    List<WorkType>? types,
  }) {
    return WorkMonth(
      id: id ?? this.id,
      date: date ?? this.date,
      days: days ?? this.days,
      types: types ?? this.types,
    );
  }

  WorkMonth deepCopy() {
    return WorkMonth(
      id: id,
      date: date,
      days: days.map((e) => e.copyWith()).toList(),
      types: types.toList(),
    );
  }
}
