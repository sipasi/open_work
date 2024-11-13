import 'package:flutter/material.dart';
import 'package:open_work_flutter/view/settings/export_import/export/option/bloc/export_options_bloc.dart';
import 'package:open_work_flutter/view/shared/input_fields/text_edit_controller.dart';
import 'package:open_work_flutter/view/shared/input_fields/text_edit_field.dart';

class NamingSection extends StatelessWidget {
  final TextEditController nameController;

  final bool canExportAsManyFiles;

  final ExportQuantity exportQuantity;

  final void Function(ExportQuantity value) onQuantityChange;
  final void Function(String value) onNameChange;

  const NamingSection({
    super.key,
    required this.nameController,
    required this.canExportAsManyFiles,
    required this.exportQuantity,
    required this.onQuantityChange,
    required this.onNameChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _quantitySegments(),
        if (exportQuantity == ExportQuantity.single) _name(),
      ],
    );
  }

  ListTile _quantitySegments() {
    return ListTile(
      title: SegmentedButton<ExportQuantity>(
        showSelectedIcon: false,
        segments: [
          ButtonSegment(
            value: ExportQuantity.single,
            label: Text('single file'),
          ),
          ButtonSegment(
            value: ExportQuantity.multiple,
            label: Text('multiple files'),
            enabled: canExportAsManyFiles,
          ),
        ],
        selected: {exportQuantity},
        onSelectionChanged: (set) => onQuantityChange(set.first),
      ),
    );
  }

  Widget _name() {
    return ListTile(
      title: TextEditField(
        controller: nameController,
        border: const OutlineInputBorder(),
        label: 'File name',
        onChanged: (value) => onNameChange(value),
      ),
    );
  }
}
