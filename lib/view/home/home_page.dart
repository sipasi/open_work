import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_work_flutter/view/home/utils/destination_converter.dart';
import 'package:open_work_flutter/view/settings/settings_page.dart';
import 'package:open_work_flutter/view/work_month/list/work_month_list_page.dart';
import 'package:open_work_flutter/view/work_type/list/work_type_list_page.dart';

import 'cubit/home_cubit.dart';
import 'widgets/app_navigation_bar.dart';
import 'widgets/destination.dart';
import 'widgets/scaffold_with_nav_bar.dart';

class HomePage extends StatelessWidget {
  static const _destinations = [
    Destination(
      label: "Types",
      icon: Icons.type_specimen_outlined,
    ),
    Destination(
      label: "Months",
      icon: Icons.calendar_month_outlined,
    ),
    Destination(
      label: "Settings",
      icon: Icons.settings_outlined,
    ),
  ];

  static final _rails = DestinationConverter.asRails(_destinations);
  static final _bottoms = DestinationConverter.asBottoms(_destinations);

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final tab = context.select((HomeCubit value) => value.state.tab);

    return ScaffoldWithNavBar(
      body: _getPageBy(tab),
      navigationBar: AppNavigationBar(
        rails: _rails,
        bottoms: _bottoms,
        current: tab.index,
        selected: (index) {
          final cubit = context.read<HomeCubit>();

          cubit.setTab(HomeTab.values[index]);
        },
      ),
    );
  }

  Widget _getPageBy(HomeTab tab) => switch (tab) {
        HomeTab.types => WorkTypeListPage(),
        HomeTab.months => WorkMonthListPage(),
        HomeTab.settings => SettingsPage(),
      };
}
