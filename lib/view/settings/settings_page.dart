import 'package:flutter/material.dart';
import 'package:open_work_flutter/theme/theme_extension.dart';
import 'package:open_work_flutter/view/settings/theme/theme_color_tile.dart';
import 'package:open_work_flutter/view/settings/theme/theme_mode_tile.dart';

import 'settings_view_model.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  late final SettingsViewModel viewmodel;

  @override
  void initState() {
    super.initState();

    viewmodel = SettingsViewModel(setState);
  }

  @override
  Widget build(BuildContext context) {
    const EdgeInsetsGeometry padding = EdgeInsets.only(top: 10.0);

    return ListView(
      padding: padding,
      children: [
        ThemeModeTile(viewmodel: viewmodel.themeController),
        ThemeColorTile(viewmodel: viewmodel.themeController),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.file_download_outlined),
          title: OutlinedButton(
            child: const Text('Import'),
            onPressed: () => viewmodel.toImport(context),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.file_upload_outlined),
          title: OutlinedButton(
            child: const Text('Export'),
            onPressed: () => viewmodel.toExport(context),
          ),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.summarize_outlined),
          title: OutlinedButton(
            child: const Text('Summarize All'),
            onPressed: () => viewmodel.toSummarizeAll(context),
          ),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.delete_forever_outlined),
          title: OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: context.colorScheme.error,
            ),
            onPressed: () => viewmodel.deleteAll(context),
            child: const Text('Delete all'),
          ),
        ),
      ],
    );
  }
}


// ListTile(
//           leading: const Icon(Icons.file_upload_outlined),
//           title: OutlinedButton(
//             child: const Text('migrate'),
//             onPressed: () async {
//               final old = await FilePicker.platform.pickFiles();
//
//               final oldFile = File(old!.paths.first!);
//
//               final oldJson = json.decode(await oldFile.readAsString());
//
//               final days = (oldJson['days'] as List<dynamic>).map((dayJson) {
//                 final dayMap = dayJson as Map<String, dynamic>;
//
//                 final works =
//                     (dayMap['works'] as List<dynamic>).map((workJson) {
//                   final calc =
//                       workJson['calculation'] as String == 'commaSeparator'
//                           ? CalculationType.itemsCount
//                           : CalculationType.numbersSum;
//
//                   WorkType type = WorkType(
//                     name: workJson['type'],
//                     calculation: calc,
//                     price: workJson['price'],
//                   );
//
//                   final description = (workJson['description'] as String);
//
//                   final units = description
//                       .split(',')
//                       .map(
//                         (e) => WorkUnit(e.trim()),
//                       )
//                       .toList();
//
//                   return Work(type, units);
//                 }).toList();
//
//                 return WorkDay(
//                   date: DateTime.parse(dayMap['date'] as String),
//                   works: works,
//                 );
//               }).toList();
//
//               final newMonth = WorkMonth(
//                 date: DateTime.parse(oldJson['date'] as String),
//                 days: days,
//                 types: [],
//               );
//
//               final asdd = newMonth.toJson();
//
//               final ddasd = json.encode(asdd);
//
//               final a = File('C:\\Users\\tanks\\Desktop\\2024-7-new.json');
//
//               await a.create();
//
//               await a.writeAsString(ddasd);
//
//               int d = 2;
//             },
//           ),
//         ),