// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:open_work_flutter/data/models/calculation_type.dart';

part 'work_type.g.dart';

@JsonSerializable(explicitToJson: true)
class WorkType {
  final int? id;

  final String name;

  final CalculationType calculation;

  final double price;

  const WorkType({
    this.id,
    required this.name,
    required this.calculation,
    required this.price,
  });
  factory WorkType.fromJson(Map<String, dynamic> json) =>
      _$WorkTypeFromJson(json);
  Map<String, dynamic> toJson() => _$WorkTypeToJson(this);

  @override
  bool operator ==(covariant WorkType other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.calculation == calculation &&
        other.price == price;
  }

  @override
  int get hashCode => name.hashCode ^ calculation.hashCode ^ price.hashCode;

  WorkType copyWith({
    int? id,
    String? name,
    CalculationType? calculation,
    double? price,
  }) {
    return WorkType(
      id: id ?? this.id,
      name: name ?? this.name,
      calculation: calculation ?? this.calculation,
      price: price ?? this.price,
    );
  }
}
