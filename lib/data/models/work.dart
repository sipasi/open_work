import 'work_type.dart';
import 'work_unit.dart';

class Work {
  final WorkType type;

  final List<WorkUnit> units;

  Work(this.type, this.units);

  factory Work.fromJson(Map<String, dynamic> json) => Work(
        WorkType.fromJson(json['type'] as Map<String, dynamic>),
        (json['units'] as List<dynamic>).map((e) => WorkUnit(e)).toList(),
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
        'type': type.toJson(),
        'units': units.map((e) => e.value).toList(),
      };
}
