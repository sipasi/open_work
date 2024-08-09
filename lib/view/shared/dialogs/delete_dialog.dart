import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  final String title;
  final Widget body;

  const DeleteDialog({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(
          color: colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: body,
      actions: [
        FilledButton.tonal(
          child: const Text('No'),
          onPressed: () => Navigator.pop(context, false),
        ),
        const SizedBox(width: 6),
        FilledButton(
          child: const Text('Yes'),
          onPressed: () => Navigator.pop(context, true),
        ),
      ],
    );
  }

  static Future<bool> showMessage({
    required BuildContext context,
    String title = 'Delete',
    String message = 'Do you realy want this?',
  }) async {
    return _show(
      showDialog<bool>(
        context: context,
        barrierDismissible: true,
        builder: (context) => DeleteDialog(
          title: title,
          body: Text(message),
        ),
      ),
    );
  }

  static Future<bool> show({
    required BuildContext context,
    required Widget body,
    String title = 'Delete',
  }) {
    return _show(
      showDialog<bool>(
        context: context,
        barrierDismissible: true,
        builder: (context) => DeleteDialog(
          title: title,
          body: body,
        ),
      ),
    );
  }

  static Future<bool> _show(Future<bool?> dialog) async {
    bool? result = await dialog;

    return result ?? false;
  }
}
