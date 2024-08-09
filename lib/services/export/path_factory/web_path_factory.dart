import 'package:open_work_flutter/services/export/path_factory/folder_location.dart';
import 'package:open_work_flutter/services/export/path_factory/path_factory.dart';

class WebPathFactory extends PathFactory {
  @override
  Future<String> local(FolderLocation location) {
    return Future.value('');
  }
}
