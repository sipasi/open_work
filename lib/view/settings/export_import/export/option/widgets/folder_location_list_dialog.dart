import 'package:flutter/material.dart';
import 'package:open_work_flutter/services/export/path_factory/folder_location.dart';
import 'package:open_work_flutter/view/shared/dialogs/list_view_dialog.dart';

class FolderLocationListDialog {
  static Future<FolderLocation?> show({
    required BuildContext context,
    required FolderLocation current,
    required void Function(FolderLocation value)? selected,
  }) async {
    const values = FolderLocation.values;

    final value = await ListViewDialog.show<FolderLocation>(
      context: context,
      length: values.length,
      builder: (index) {
        final value = values[index];

        return ListTile(
          title: Text(value.label),
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
