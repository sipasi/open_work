import 'package:flutter/material.dart';
import 'package:open_work_flutter/theme/color/color_seed.dart';
import 'package:open_work_flutter/view/shared/dialogs/list_view_dialog.dart';

class ColorListDialog {
  static Future<ColorSeed?> show({
    required BuildContext context,
    required ColorSeed current,
  }) async {
    const values = ColorSeed.values;

    final value = await ListViewDialog.show<ColorSeed>(
      context: context,
      length: values.length,
      builder: (index) {
        final value = values[index];
        final color = values[index].color;

        return ListTile(
          title: Text(value.label),
          trailing: Icon(
            Icons.circle,
            color: color,
          ),
          selected: current == value,
          onTap: () => Navigator.pop(context, values[index]),
        );
      },
    );

    return value;
  }
}
