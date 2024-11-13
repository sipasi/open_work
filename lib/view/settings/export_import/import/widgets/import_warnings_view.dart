import 'package:flutter/material.dart';
import 'package:open_work_flutter/view/settings/export_import/import/bloc/settings_import_bloc.dart';

class ImportWarningsResult {
  final MonthExistBehavior shouldOverwriteExisted;
  final WorkTypeBehavior shouldAddTypesToStorage;

  final bool cancel;

  ImportWarningsResult({
    required this.shouldOverwriteExisted,
    required this.shouldAddTypesToStorage,
    required this.cancel,
  });

  factory ImportWarningsResult.fromBool({
    required bool shouldOverwriteExisted,
    required bool shouldAddTypesToStorage,
  }) {
    return ImportWarningsResult(
      shouldOverwriteExisted: shouldOverwriteExisted
          ? MonthExistBehavior.overwrite
          : MonthExistBehavior.skip,
      shouldAddTypesToStorage: shouldAddTypesToStorage
          ? WorkTypeBehavior.addToStorage
          : WorkTypeBehavior.skip,
      cancel: false,
    );
  }

  ImportWarningsResult.cancel()
      : shouldOverwriteExisted = MonthExistBehavior.skip,
        shouldAddTypesToStorage = WorkTypeBehavior.skip,
        cancel = true;
}

class ImportWarningsView extends StatefulWidget {
  final bool shouldOverwriteExisted;
  final bool shouldAddTypesToStorage;

  const ImportWarningsView({
    super.key,
    required this.shouldOverwriteExisted,
    required this.shouldAddTypesToStorage,
  });

  @override
  State<ImportWarningsView> createState() => _ImportWarningsViewState();

  static Future<ImportWarningsResult> dialog({
    required BuildContext context,
    required bool shouldOverwriteExisted,
    required bool shouldAddTypesToStorage,
  }) async {
    final result = await showDialog<ImportWarningsResult>(
      context: context,
      barrierDismissible: false,
      builder: (context) => ImportWarningsView(
        shouldOverwriteExisted: shouldOverwriteExisted,
        shouldAddTypesToStorage: shouldAddTypesToStorage,
      ),
    );

    return result ??
        ImportWarningsResult.fromBool(
          shouldOverwriteExisted: shouldOverwriteExisted,
          shouldAddTypesToStorage: shouldAddTypesToStorage,
        );
  }
}

class _ImportWarningsViewState extends State<ImportWarningsView> {
  late bool shouldOverwriteExisted;
  late bool shouldAddTypesToStorage;

  @override
  void initState() {
    super.initState();

    shouldOverwriteExisted = widget.shouldOverwriteExisted;
    shouldAddTypesToStorage = widget.shouldAddTypesToStorage;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SwitchListTile(
            title: Text('overwrite existed months'),
            value: shouldOverwriteExisted,
            onChanged: (value) => setState(
              () => shouldOverwriteExisted = value,
            ),
          ),
          SwitchListTile(
            title: Text('add types from imports'),
            value: shouldAddTypesToStorage,
            onChanged: (value) => setState(
              () => shouldAddTypesToStorage = value,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text('cancel'),
          onPressed: () => Navigator.pop(
            context,
            ImportWarningsResult.cancel(),
          ),
        ),
        FilledButton(
          child: Text('import'),
          onPressed: () => Navigator.pop(
            context,
            ImportWarningsResult.fromBool(
              shouldOverwriteExisted: shouldOverwriteExisted,
              shouldAddTypesToStorage: shouldAddTypesToStorage,
            ),
          ),
        ),
      ],
    );
  }
}
