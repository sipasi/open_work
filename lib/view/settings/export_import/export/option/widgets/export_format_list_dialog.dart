import 'package:flutter/material.dart';
import 'package:open_work_flutter/services/export/export_format.dart';
import 'package:open_work_flutter/view/shared/dialogs/list_view_dialog.dart';

class ExportFormatListDialog {
  static Future<ExportFormat?> show({
    required BuildContext context,
    required ExportFormat current,
    required void Function(ExportFormat value)? selected,
  }) async {
    const values = ExportFormat.values;

    final value = await ListViewDialog.show<ExportFormat>(
      context: context,
      length: values.length,
      builder: (index) {
        final value = values[index];

        return ListTile(
          title: Text(value.name),
          trailing: const Icon(
            Icons.circle,
          ),
          selected: current == value,
          onTap: () => Navigator.pop(context, values[index]),
        );
      },
    );

    if (selected != null && value != null) selected(value);

    return value;
  }
}
