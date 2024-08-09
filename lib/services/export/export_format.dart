enum ExportFormat {
  json('json'),
  text('txt');

  const ExportFormat(this.extension);
  final String extension;
}
