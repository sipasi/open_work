import 'package:flutter/material.dart';

class ActionDialog extends StatelessWidget {
  final Widget title;
  final Widget content;
  final String yes;
  final String no;

  const ActionDialog({
    super.key,
    required this.title,
    required this.content,
    this.yes = 'yes',
    this.no = 'no',
  });

  static Future<bool> show({
    required BuildContext context,
    required Widget title,
    required Widget content,
    String yes = 'yes',
    String no = 'no',
    bool barrierDismissible = true,
  }) async {
    final result = await showDialog<bool>(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (context) {
        return ActionDialog(
          title: title,
          content: content,
          yes: yes,
          no: no,
        );
      },
    );

    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: content,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(no),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(yes),
        ),
      ],
    );
  }
}
