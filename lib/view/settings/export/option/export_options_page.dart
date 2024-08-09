// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/services/export/path_factory/folder_location.dart';
import 'package:open_work_flutter/view/shared/dialogs/folder_location_list_dialog.dart';
import 'package:open_work_flutter/view/shared/input_fields/text_edit_field.dart';

import 'export_options_view_model.dart';

class ExportOptionsPage extends StatefulWidget {
  final List<WorkMonth> groups;

  const ExportOptionsPage({super.key, required this.groups});

  @override
  State<ExportOptionsPage> createState() => _ExportOptionsPageState();
}

class _ExportOptionsPageState extends State<ExportOptionsPage> {
  late final ExportOptionsViewModel viewmodel;

  @override
  void initState() {
    super.initState();

    viewmodel = ExportOptionsViewModel(groups: widget.groups);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          _NamingSection(
            viewmodel: viewmodel,
            oneFileSwitch: (value) => setState(
              () => viewmodel.switchOneFile(value),
            ),
            onNameChange: () => setState(
              () => viewmodel.onNameChange(),
            ),
          ),
          const Divider(height: 40),
          _DownloadSection(
            viewmodel: viewmodel,
            onDownloadSwitched: (value) => setState(
              () => viewmodel.switchDownload(value),
            ),
            onLocationSelected: (value) => setState(
              () => viewmodel.selectLocation(value),
            ),
          ),
        ],
      ),
      floatingActionButton: getFab(),
    );
  }

  Widget getFab() {
    final result = switch (viewmodel) {
      ExportOptionsViewModel(canOnlyDownload: true) => (
          'Download',
          Icons.download_outlined
        ),
      ExportOptionsViewModel(download: true) => (
          'Download',
          Icons.download_outlined
        ),
      _ => ('Share', Icons.share_outlined),
    };

    return FloatingActionButton.extended(
      label: Text(result.$1),
      icon: Icon(result.$2),
      onPressed: () {
        viewmodel.perform(context);
      },
    );
  }
}

class _NamingSection extends StatelessWidget {
  final ExportOptionsViewModel viewmodel;

  final void Function(bool value) oneFileSwitch;
  final void Function() onNameChange;

  const _NamingSection({
    required this.viewmodel,
    required this.oneFileSwitch,
    required this.onNameChange,
  });

  @override
  Widget build(BuildContext context) {
    if (viewmodel.canExportAsManyFiles) {
      return Column(
        children: [
          if (viewmodel.isMany) _oneFileSwitch(),
          if (viewmodel.oneFile) _name(),
        ],
      );
    }

    return _name();
  }

  Widget _oneFileSwitch() {
    return ListTile(
      title: const Text('As one file'),
      trailing: Switch(
        value: viewmodel.oneFile,
        onChanged: oneFileSwitch,
      ),
    );
  }

  Widget _name() {
    return ListTile(
      title: TextEditField(
        controller: viewmodel.name,
        border: const OutlineInputBorder(),
        label: 'File name',
        onChanged: (_) => onNameChange(),
      ),
    );
  }
}

class _DownloadSection extends StatelessWidget {
  final ExportOptionsViewModel viewmodel;

  final void Function(bool value) onDownloadSwitched;
  final void Function(FolderLocation location) onLocationSelected;

  const _DownloadSection({
    required this.viewmodel,
    required this.onDownloadSwitched,
    required this.onLocationSelected,
  });

  @override
  Widget build(BuildContext context) {
    final scheem = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final bodyLarge =
        textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold);

    if (viewmodel.canOnlyDownload) {
      return RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Web',
                style: bodyLarge?.copyWith(color: scheem.primary),
              ),
              TextSpan(
                text: ' is currently ',
                style: bodyLarge,
              ),
              TextSpan(
                text: 'limited',
                style: bodyLarge?.copyWith(color: scheem.error),
              ),
              TextSpan(
                text: ' to file downloads only',
                style: bodyLarge,
              ),
            ],
          ));
    }

    return Column(
      children: [
        _downloadSwitch(),
        if (viewmodel.download) _folderSelector(context, scheem),
      ],
    );
  }

  Widget _downloadSwitch() {
    return ListTile(
      title: const Text('Save on device'),
      trailing: Switch(
        value: viewmodel.download,
        onChanged: onDownloadSwitched,
      ),
    );
  }

  Widget _folderSelector(BuildContext context, ColorScheme scheme) {
    return ListTile(
      title: Text(
        'Folder',
        style: TextStyle(color: scheme.primary),
      ),
      subtitle: Text(viewmodel.location.label),
      leading: const Icon(Icons.folder),
      onTap: () {
        FolderLocationListDialog.show(
          context: context,
          current: viewmodel.location,
          selected: onLocationSelected,
        );
      },
    );
  }
}
