import 'package:json_annotation/json_annotation.dart';

import 'calculation_type_old.dart';

class WorkOld {
  final double price;

  final String type;

  final CalculationTypeOld calculation;

  final String description;

  const WorkOld({
    required this.price,
    required this.type,
    required this.calculation,
    required this.description,
  });

  factory WorkOld.fromJson(Map<String, dynamic> json) => WorkOld(
        price: (json['price'] as num).toDouble(),
        type: json['type'] as String,
        calculation: $enumDecode(_$CalculationTypeEnumMap, json['calculation']),
        description: json['description'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'price': price,
        'type': type,
        'calculation': _$CalculationTypeEnumMap[calculation]!,
        'description': description,
      };

  static const _$CalculationTypeEnumMap = {
    CalculationTypeOld.hour: 'hour',
    CalculationTypeOld.commaSeparator: 'commaSeparator',
  };
}
