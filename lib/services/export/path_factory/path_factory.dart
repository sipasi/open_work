import 'package:open_work_flutter/services/export/path_factory/folder_location.dart';

abstract class PathFactory {
  Future<String> local(FolderLocation location);
}
