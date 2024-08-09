// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_month.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkMonth _$WorkMonthFromJson(Map<String, dynamic> json) => WorkMonth(
      id: (json['id'] as num?)?.toInt(),
      date: DateTime.parse(json['date'] as String),
      days: (json['days'] as List<dynamic>)
          .map((e) => WorkDay.fromJson(e as Map<String, dynamic>))
          .toList(),
      types: (json['types'] as List<dynamic>)
          .map((e) => WorkType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WorkMonthToJson(WorkMonth instance) => <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'days': instance.days.map((e) => e.toJson()).toList(),
      'types': instance.types.map((e) => e.toJson()).toList(),
    };
