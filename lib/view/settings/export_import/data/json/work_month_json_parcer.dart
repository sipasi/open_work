import 'dart:convert';

import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/view/settings/export_import/data/json/json_parcer.dart';

class WorkMonthJsonParcer extends JsonParcer<List<WorkMonth>> {
  @override
  List<WorkMonth> from(String text) {
    final decoded = json.decode(text);

    if (decoded is List<dynamic>) {
      final result = decoded.map((item) => WorkMonth.fromJson(item));

      return result.toList();
    }
    if (decoded is Map<String, dynamic>) {
      return [
        WorkMonth.fromJson(decoded),
      ];
    }

    return List.empty();
  }

  @override
  String to(List<WorkMonth> entity) {
    final list = entity.map((item) => item.toJson()).toList();

    return jsonEncode(list);
  }
}
