// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkDay _$WorkDayFromJson(Map<String, dynamic> json) => WorkDay(
      date: DateTime.parse(json['date'] as String),
      works: (json['works'] as List<dynamic>)
          .map((e) => Work.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WorkDayToJson(WorkDay instance) => <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'works': instance.works.map((e) => e.toJson()).toList(),
    };
