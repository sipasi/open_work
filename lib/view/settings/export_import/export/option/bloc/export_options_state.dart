part of 'export_options_bloc.dart';

enum ExportQuantity {
  single, // Export one file
  multiple, // Export multiple files
}

enum ExportMethod {
  localDevice, // Export to a local device
  shared, // Export for sharing with others
}

enum ExportStatus {
  notStarted,
  readyToExport,
}

final class ExportOptionsState {
  static const String defaultName = 'Months';

  final List<WorkMonth> months;

  final String fileName;

  final ExportQuantity exportQuantity;
  final ExportMethod exportMethod;
  final ExportFormat exportFormat;

  final FolderLocation folderLocation;

  final ExportStatus status;

  bool get isEmpty => months.isEmpty;
  bool get isSingle => months.length == 1;
  bool get isMany => months.length > 1;

  bool get canExportAsManyFiles => !isWeb && isMany;
  bool get exportOnlyOnDevice => isWeb;

  bool get isWeb => kIsWeb;

  const ExportOptionsState({
    required this.months,
    required this.fileName,
    required this.exportQuantity,
    required this.exportMethod,
    required this.folderLocation,
    required this.exportFormat,
    required this.status,
  });
  const ExportOptionsState.initial(this.months)
      : fileName = defaultName,
        exportMethod =
            kIsWeb ? ExportMethod.localDevice : ExportMethod.localDevice,
        exportQuantity = ExportQuantity.single,
        exportFormat = ExportFormat.json,
        folderLocation = FolderLocation.downloads,
        status = ExportStatus.notStarted;

  ExportOptionsState copyWith({
    String? fileName,
    ExportQuantity? exportQuantity,
    ExportMethod? exportMethod,
    ExportFormat? exportFormat,
    FolderLocation? folderLocation,
    ExportStatus? status,
  }) {
    return ExportOptionsState(
      months: months,
      fileName: fileName ?? this.fileName,
      exportQuantity: exportQuantity ?? this.exportQuantity,
      exportMethod: exportMethod ?? this.exportMethod,
      folderLocation: folderLocation ?? this.folderLocation,
      exportFormat: exportFormat ?? this.exportFormat,
      status: status ?? this.status,
    );
  }
}
