// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:open_work_flutter/theme/theme_extension.dart';
import 'package:open_work_flutter/view/shared/dialogs/delete_dialog.dart';
import 'package:open_work_flutter/view/work_month/edit/data/supported_type.dart';
import 'package:open_work_flutter/view/work_month/edit/data/template_type.dart';

class WorkMonthEditDialog {
  static Future<bool> changesOnSave({
    required BuildContext context,
    required List<SupportedType> removed,
    required List<TemplateType> added,
  }) {
    final deletedStyle = context.textTheme.bodyMedium?.copyWith(
      color: context.colorScheme.error,
    );
    final addedStyle = context.textTheme.bodyMedium?.copyWith(
      color: context.colorScheme.primary,
    );

    return DeleteDialog.show(
      context: context,
      title: 'Changes',
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...removed.map((e) {
              final name = e.type.name;
              final price = e.type.price.toString();

              return Text('- $name $price', style: deletedStyle);
            }),
            const SizedBox(height: 4),
            ...added.map(
              (e) {
                final name = e.type.name;
                final price = e.type.price.toString();

                return Text('+ $name $price', style: addedStyle);
              },
            ),
          ],
        ),
      ),
    );
  }

  static Future<bool> deleteSupportedType({
    required BuildContext context,
    required SupportedType type,
  }) {
    return DeleteDialog.showMessage(
      context: context,
      title: type.type.name,
      message: 'Do you want to delete all records on sum of ${type.sum}',
    );
  }
}
