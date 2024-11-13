import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/services/export/export_format.dart';
import 'package:open_work_flutter/services/export/path_factory/folder_location.dart';
import 'package:open_work_flutter/view/shared/input_fields/text_edit_controller.dart';

class ExportOptionsViewModel {
  static const String _defauldName = 'Months';

  final List<WorkMonth> _groups;

  bool _oneFile;
  bool _download;
  FolderLocation _location;
  ExportFormat _format;

  final TextEditController name;

  bool get oneFile => _oneFile;
  bool get download => _download;
  FolderLocation get location => _location;
  ExportFormat get format => _format;

  bool get isEmpty => _groups.isEmpty;
  bool get isSingle => _groups.length == 1;
  bool get isMany => _groups.length > 1;

  bool get canExportAsManyFiles => isWeb == false && isMany;
  bool get canOnlyDownload => isWeb;

  bool get isWeb => kIsWeb;

  ExportOptionsViewModel({required List<WorkMonth> groups})
      : _groups = groups,
        _oneFile = true,
        _download = kIsWeb ? true : false,
        _location = FolderLocation.downloads,
        _format = ExportFormat.json,
        name = TextEditController.text(text: _defauldName) {
    if (isSingle) {
      final date = groups[0].date;

      name.setText('${date.year}-${date.month}');
    }
  }

  void onNameChange() {
    name.setErrorIfEmpty();
  }

  void switchOneFile(bool value) {
    _oneFile = value;
  }

  void switchDownload(bool value) {
    _download = value;
  }

  void selectLocation(FolderLocation? value) {
    if (value == null) {
      return;
    }

    _location = value;
  }

  void selectFormat(ExportFormat? value) {
    if (value == null) {
      return;
    }

    _format = value;
  }

  Future _onShare(BuildContext context) async {
    // final factory = WorkMonthFormatterFactory();

    // return ShareFile.shareData(
    //   context: context,
    //   data: _groups,
    //   format: _format,
    //   formatter: factory.create(_format),
    //   name: name.textTrim,
    //   options: options,
    // );
  }
}
