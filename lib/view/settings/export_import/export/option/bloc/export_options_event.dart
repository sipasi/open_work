part of 'export_options_bloc.dart';

sealed class ExportOptionsEvent {
  const ExportOptionsEvent();
}

final class ExportOptionsExportQuantityChanged extends ExportOptionsEvent {
  final ExportQuantity value;

  ExportOptionsExportQuantityChanged(this.value);
}

final class ExportOptionsNameChanged extends ExportOptionsEvent {
  final String value;

  ExportOptionsNameChanged(this.value);
}

final class ExportOptionsExportFormatChanged extends ExportOptionsEvent {
  final ExportFormat value;

  ExportOptionsExportFormatChanged(this.value);
}

final class ExportOptionsExportMethodChanged extends ExportOptionsEvent {
  final ExportMethod value;

  ExportOptionsExportMethodChanged(this.value);
}

final class ExportOptionsFolderLocationChanged extends ExportOptionsEvent {
  final FolderLocation value;

  ExportOptionsFolderLocationChanged(this.value);
}

final class ExportOptionsPerformRequested extends ExportOptionsEvent {
  ExportOptionsPerformRequested();
}
