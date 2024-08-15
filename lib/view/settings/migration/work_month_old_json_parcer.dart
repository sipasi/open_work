import 'dart:convert';

import 'package:open_work_flutter/view/settings/json/json_parcer.dart';

import 'old_models/work_month_old.dart';

class WorkMonthOldJsonParcer extends JsonParcer<List<WorkMonthOld>> {
  @override
  List<WorkMonthOld> from(String text) {
    final decoded = json.decode(text);

    if (decoded is List<dynamic>) {
      final result = decoded.map((item) => WorkMonthOld.fromJson(item));

      return result.toList();
    }
    if (decoded is Map<String, dynamic>) {
      return [
        WorkMonthOld.fromJson(decoded),
      ];
    }

    return List.empty();
  }

  @override
  String to(List<WorkMonthOld> entity) {
    final list = entity.map((item) => item.toJson()).toList();

    return jsonEncode(list);
  }
}
