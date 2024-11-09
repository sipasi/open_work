import 'package:flutter/material.dart';

class AppNavigationBar {
  final int current;

  final List<NavigationRailDestination> rails;
  final List<NavigationDestination> bottoms;

  final void Function(int) selected;

  AppNavigationBar({
    required this.current,
    required this.rails,
    required this.bottoms,
    required this.selected,
  });

  Widget asRail() {
    return NavigationRail(
      destinations: rails,
      selectedIndex: current,
      onDestinationSelected: selected,
      groupAlignment: 0,
    );
  }

  Widget asBottom() {
    return NavigationBar(
      destinations: bottoms,
      selectedIndex: current,
      onDestinationSelected: selected,
    );
  }
}
