import 'package:flutter/material.dart';
import 'package:open_work_flutter/data/models/work_type.dart';
import 'package:open_work_flutter/theme/theme_extension.dart';
import 'package:open_work_flutter/view/shared/dialogs/list_view_dialog.dart';

class WorkTypeListDialog {
  static Future<WorkType?> show({
    required BuildContext context,
    required List<WorkType> types,
    required WorkType current,
  }) {
    return ListViewDialog.show(
      context: context,
      length: types.length,
      builder: (index) {
        final value = types[index];

        final selected = current == value;

        return ListTile(
          title: Text(value.name),
          trailing: selected
              ? Icon(
                  Icons.circle,
                  color: context.colorScheme.primary,
                )
              : null,
          selected: selected,
          onTap: () => Navigator.pop(context, value),
        );
      },
    );
  }
}
