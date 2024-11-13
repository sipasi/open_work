import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/services/export/formatter/format_options.dart';
import 'package:open_work_flutter/services/export/work_month/work_month_export_service.dart';
import 'package:open_work_flutter/services/navigation/material_navigator.dart';
import 'package:open_work_flutter/view/settings/export_import/export/option/bloc/export_options_bloc.dart';
import 'package:open_work_flutter/view/settings/export_import/export/option/widgets/download_section.dart';
import 'package:open_work_flutter/view/settings/export_import/export/option/widgets/naming_section.dart';
import 'package:open_work_flutter/view/shared/dialogs/waiting_dialog.dart';
import 'package:open_work_flutter/view/shared/input_fields/text_edit_controller.dart';

class ExportOptionsPage extends StatelessWidget {
  final TextEditController nameContoller = TextEditController.text();

  final List<WorkMonth> months;

  ExportOptionsPage({super.key, required this.months});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExportOptionsBloc(months: months),
      child: ExportOptionsView(nameContoller: nameContoller),
    );
  }
}

class ExportOptionsView extends StatelessWidget {
  final TextEditController nameContoller;

  const ExportOptionsView({super.key, required this.nameContoller});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExportOptionsBloc, ExportOptionsState>(
      listenWhen: (previous, current) =>
          current.status == ExportStatus.readyToExport,
      listener: (context, state) async {
        final export = GetIt.I.get<WorkMonthExportService>();

        final future = export.exportTo(
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
          fileNamePlaceholder: ExportOptionsState.defaultName,
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
