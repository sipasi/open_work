import 'package:open_work_flutter/data/models/work_type.dart';
import 'package:open_work_flutter/data/models/work_unit.dart';
import 'package:open_work_flutter/data/summaries/summary_model.dart';
import 'package:open_work_flutter/view/work_month/edit/data/pair_type.dart';

final class SupportedType extends PairType {
  final TypeInfo info;

  final bool deleted;

  @override
  WorkType get type => info.type;

  int get count => info.count;
  double get sum => info.sum;

  List<WorkUnit> get units => info.units;

  const SupportedType(super.id, this.info, [this.deleted = false]);

  SupportedType revertDeleted() => SupportedType(id, info, !deleted);

  @override
  SupportedType deepCopy() {
    return SupportedType(id, info, deleted);
  }
}
