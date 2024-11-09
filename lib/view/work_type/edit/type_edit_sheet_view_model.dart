import 'package:open_work_flutter/data/models/calculation_type.dart';
import 'package:open_work_flutter/data/models/work_type.dart';
import 'package:open_work_flutter/storage/type_storage.dart';

class TypeEditSheetViewModel {
  final int? _id;
  final TypeStorage _typeStorage;

  String _name;
  String _price;
  CalculationType _calculation;

  String get name => _name;
  String get price => _price;
  CalculationType get calculation => _calculation;

  bool get canSubmit => _name.trim().isNotEmpty && _price.trim().isNotEmpty;

  TypeEditSheetViewModel({
    required TypeStorage typeStorage,
    required WorkType? entity,
  })  : _typeStorage = typeStorage,
        _id = entity?.id,
        _name = entity?.name ?? '',
        _price = entity?.price.toString() ?? '',
        _calculation = entity?.calculation ?? CalculationType.itemsCount;

  void setCalculation(CalculationType value) => _calculation = value;

  void setName(String value) => _name = value;

  void setPrice(String value) => _price = value;

  Future<bool> trySubmit() async {
    final trimmedName = _name.trim();

    if (trimmedName.isEmpty) {
      return false;
    }

    double? price = double.tryParse(_price);

    if (price == null) {
      return false;
    }

    WorkType type = WorkType(
      id: _id,
      name: trimmedName,
      price: price,
      calculation: _calculation,
    );

    await _typeStorage.updateOrCreate(type);

    return true;
  }

  Future tryDelete() async {
    if (_id == null) {
      return;
    }

    await _typeStorage.delete(_id);
  }
}
