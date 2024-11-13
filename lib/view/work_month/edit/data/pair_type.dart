import 'package:equatable/equatable.dart';
import 'package:open_work_flutter/data/models/work_type.dart';

abstract class PairType extends Equatable {
  final int id;

  WorkType get type;

  const PairType(this.id);

  PairType deepCopy();

  @override
  List<Object?> get props => [id];
}
