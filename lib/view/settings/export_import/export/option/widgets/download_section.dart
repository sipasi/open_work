import 'package:flutter/material.dart';
import 'package:open_work_flutter/services/export/export_format.dart';
import 'package:open_work_flutter/services/export/path_factory/folder_location.dart';
import 'package:open_work_flutter/theme/theme_extension.dart';
import 'package:open_work_flutter/view/settings/export_import/export/option/bloc/export_options_bloc.dart';
import 'package:open_work_flutter/view/settings/export_import/export/option/widgets/export_format_list_dialog.dart';
import 'package:open_work_flutter/view/settings/export_import/export/option/widgets/folder_location_list_dialog.dart';

class DownloadSection extends StatelessWidget {
  final bool exportOnlyOnDevice;
  final ExportFormat exportFormat;
  final ExportMethod exportMethod;
  final FolderLocation folderLocation;

  final void Function(ExportFormat value) onExportFormatChanged;
  final void Function(ExportMethod value) onExportMethodChanged;
  final void Function(FolderLocation value) onLocationChanged;

  const DownloadSection({
    super.key,
    required this.exportOnlyOnDevice,
    required this.exportFormat,
    required this.exportMethod,
    required this.folderLocation,
    required this.onExportFormatChanged,
    required this.onExportMethodChanged,
    required this.onLocationChanged,
  });

  @override
  Widget build(BuildContext context) {
    final scheem = context.colorScheme;
    final textTheme = context.textTheme;

    final bodyLarge = textTheme.bodyLarge?.copyWith(
      fontWeight: FontWeight.bold,
    );

    if (exportOnlyOnDevice) {
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
        ),
      );
    }

    return Column(
      children: [
        _exportSegments(),
        _formatSelector(context, scheem),
        if (exportMethod == ExportMethod.localDevice)
          _folderSelector(context, scheem),
      ],
    );
  }

  ListTile _exportSegments() {
    return ListTile(
      title: SegmentedButton<ExportMethod>(
        showSelectedIcon: false,
        segments: [
          ButtonSegment(
            value: ExportMethod.shared,
            label: Text('sharing'),
            enabled: exportOnlyOnDevice == false,
          ),
          ButtonSegment(
            value: ExportMethod.localDevice,
            label: Text('local on device'),
          ),
        ],
        selected: {exportMethod},
        onSelectionChanged: (set) => onExportMethodChanged(set.first),
        expandedInsets: EdgeInsets.zero,
      ),
    );
  }

  Widget _formatSelector(BuildContext context, ColorScheme scheme) {
    return ListTile(
      title: Text(
        'Format',
        style: TextStyle(color: scheme.primary),
      ),
      subtitle: Text(exportFormat.name),
      leading: const Icon(Icons.extension_outlined),
      onTap: () {
        ExportFormatListDialog.show(
          context: context,
          current: exportFormat,
          selected: onExportFormatChanged,
        );
      },
    );
  }

  Widget _folderSelector(BuildContext context, ColorScheme scheme) {
    return ListTile(
      title: Text(
        'Folder',
        style: TextStyle(color: scheme.primary),
      ),
      subtitle: Text(folderLocation.label),
      leading: const Icon(Icons.folder_outlined),
      onTap: () {
        FolderLocationListDialog.show(
          context: context,
          current: folderLocation,
          selected: onLocationChanged,
        );
      },
    );
  }
}
