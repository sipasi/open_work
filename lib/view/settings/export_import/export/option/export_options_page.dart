import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/services/export/formatter/format_options.dart';
import 'package:open_work_flutter/services/export/work_month/work_month_export_service.dart';
import 'package:open_work_flutter/services/export/work_month/work_month_formatter_factory.dart';
import 'package:open_work_flutter/services/navigation/material_navigator.dart';
import 'package:open_work_flutter/view/settings/export_import/export/option/bloc/export_options_bloc.dart';
import 'package:open_work_flutter/view/settings/export_import/export/option/widgets/download_section.dart';
import 'package:open_work_flutter/view/settings/export_import/export/option/widgets/naming_section.dart';
import 'package:open_work_flutter/view/shared/dialogs/waiting_dialog.dart';
import 'package:open_work_flutter/view/shared/input_fields/text_edit_controller.dart';
import 'package:share_plus/share_plus.dart';

class ExportOptionsPage extends StatelessWidget {
  final List<WorkMonth> months;

  const ExportOptionsPage({super.key, required this.months});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExportOptionsBloc(months: months),
      child: ExportOptionsView(),
    );
  }
}

class ExportOptionsView extends StatefulWidget {
  const ExportOptionsView({super.key});

  @override
  State<ExportOptionsView> createState() => _ExportOptionsViewState();
}

class _ExportOptionsViewState extends State<ExportOptionsView> {
  final TextEditController nameContoller = TextEditController.text();

  @override
  void initState() {
    super.initState();

    nameContoller.setText(_bloc(context).state.fileName);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExportOptionsBloc, ExportOptionsState>(
      listenWhen: (previous, current) =>
          current.status == ExportStatus.readyToExport &&
          current.months.isNotEmpty,
      listener: (context, state) async {
        late Future future;

        if (state.exportMethod == ExportMethod.localDevice) {
          final export = GetIt.I.get<WorkMonthExportService>();

          future = export.exportTo(
            state.folderLocation,
            state.months,
            state.fileName.trim(),
            state.exportFormat,
            const FormatOptions(),
          );

          await WaitingDialog.show(
            context: context,
            title: 'Downloading...',
            future: future,
          );
        }
        if (state.exportMethod == ExportMethod.shared) {
          final factory = WorkMonthFormatterFactory();

          final formatter = factory.create(state.exportFormat);

          final data = await formatter.format(
            state.months,
            const FormatOptions(),
          );

          final file = XFile.fromData(Uint8List.fromList(data));

          await Share.shareXFiles(
            [file],
            fileNameOverrides: [
              '${state.fileName}.${state.exportFormat.extension}'
            ],
          );
        }

        MaterialNavigator.pop(context, times: 2);
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: _body(context, state),
          floatingActionButton: _fab(context),
        );
      },
    );
  }

  Widget _body(BuildContext context, ExportOptionsState state) {
    return Column(
      children: [
        NamingSection(
          nameController: nameContoller,
          exportQuantity: state.exportQuantity,
          canExportAsManyFiles: state.canExportAsManyFiles,
          onQuantityChange: (value) => _bloc(context).add(
            ExportOptionsExportQuantityChanged(value),
          ),
          onNameChange: (value) => _bloc(context).add(
            ExportOptionsNameChanged(value),
          ),
        ),
        const Divider(height: 40),
        DownloadSection(
          exportOnlyOnDevice: state.exportOnlyOnDevice,
          exportFormat: state.exportFormat,
          exportMethod: state.exportMethod,
          folderLocation: state.folderLocation,
          onExportFormatChanged: (value) => _bloc(context).add(
            ExportOptionsExportFormatChanged(value),
          ),
          onExportMethodChanged: (value) => _bloc(context).add(
            ExportOptionsExportMethodChanged(value),
          ),
          onLocationChanged: (value) => _bloc(context).add(
            ExportOptionsFolderLocationChanged(value),
          ),
        ),
      ],
    );
  }

  Widget _fab(BuildContext context) {
    final result = switch (_bloc(context).state) {
      ExportOptionsState(exportOnlyOnDevice: true) => (
          'Download',
          Icons.download_outlined
        ),
      ExportOptionsState(exportMethod: ExportMethod.localDevice) => (
          'Download',
          Icons.download_outlined
        ),
      _ => ('Share', Icons.share_outlined),
    };

    return FloatingActionButton.extended(
      label: Text(result.$1),
      icon: Icon(result.$2),
      onPressed: () => _bloc(context).add(
        ExportOptionsPerformRequested(),
      ),
    );
  }

  ExportOptionsBloc _bloc(BuildContext context) => context.read();
}
