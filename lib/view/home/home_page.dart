import 'package:flutter/material.dart';
import 'package:open_work_flutter/view/home/app_navigation_bar.dart';
import 'package:open_work_flutter/view/settings/settings_page.dart';
import 'package:open_work_flutter/view/work_month/list/work_month_list_page.dart';
import 'package:open_work_flutter/view/work_type/list/work_type_list_page.dart';

import 'navigation_destination_base.dart';
import 'scaffold_with_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 1;

  final destinations = const [
    NavigationDestinationBase(
      label: "Types",
      icon: Icons.type_specimen_outlined,
    ),
    NavigationDestinationBase(
      label: "Months",
      icon: Icons.calendar_month_outlined,
    ),
    NavigationDestinationBase(
      label: "Settings",
      icon: Icons.settings_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithNavBar(
      body: getPageBy(pageIndex),
      navigationBar: AppNavigationBar(
        current: pageIndex,
        items: destinations,
        selected: onDestinationSelected,
      ),
    );
  }

  void onDestinationSelected(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  Widget getPageBy(int index) => switch (index) {
        0 => const WorkTypeListPage(),
        1 => const WorkMonthListPage(),
        2 => const SettingsPage(),
        _ => const WorkMonthListPage(),
      };
}
