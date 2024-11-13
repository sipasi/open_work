import 'package:open_work_flutter/data/models/work_type.dart';
import 'package:open_work_flutter/view/work_month/edit/data/pair_type.dart';

class TemplateType extends PairType {
  final WorkType _type;

  final bool selected;

  @override
  WorkType get type => _type;

  const TemplateType(super.id, this._type, [this.selected = false]);

  TemplateType revertSelected() => TemplateType(id, _type, !selected);

  @override
  TemplateType deepCopy() {
    return TemplateType(id, _type, selected);
  }

  TemplateType copyWithSelected(bool selected) {
    return TemplateType(id, _type, selected);
  }
}
