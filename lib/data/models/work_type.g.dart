// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkType _$WorkTypeFromJson(Map<String, dynamic> json) => WorkType(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      calculation: $enumDecode(_$CalculationTypeEnumMap, json['calculation']),
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$WorkTypeToJson(WorkType instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'calculation': _$CalculationTypeEnumMap[instance.calculation]!,
      'price': instance.price,
    };

const _$CalculationTypeEnumMap = {
  CalculationType.numbersSum: 'numbersSum',
  CalculationType.itemsCount: 'itemsCount',
};
