import 'package:json_annotation/json_annotation.dart';

import 'calculation_type_old.dart';

class WorkTypeOld {
  final String id;

  final String name;

  final CalculationTypeOld calculation;

  final double price;

  const WorkTypeOld({
    required this.id,
    required this.name,
    required this.calculation,
    required this.price,
  });

  factory WorkTypeOld.fromJson(Map<String, dynamic> json) => WorkTypeOld(
        id: json['id'] as String,
        name: json['name'] as String,
        calculation: $enumDecode(_$CalculationTypeEnumMap, json['calculation']),
        price: (json['price'] as num).toDouble(),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'calculation': _$CalculationTypeEnumMap[calculation]!,
        'price': price,
      };

  static const _$CalculationTypeEnumMap = {
    CalculationTypeOld.hour: 'hour',
    CalculationTypeOld.commaSeparator: 'commaSeparator',
  };
}
