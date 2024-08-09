import 'package:open_work_flutter/services/export/save_provider/save_provider.dart';
import 'package:universal_html/html.dart' as html;

class WebBrowserSaver extends SaveProvider {
  @override
  Future save(List<int> data, String path) async {
    final blob = html.Blob([data]);

    final url = html.Url.createObjectUrlFromBlob(blob);

    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = path;

    html.document.body?.children.add(anchor);

// download
    anchor.click();

// cleanup
    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }
}
