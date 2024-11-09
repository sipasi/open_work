import 'package:flutter/material.dart';
import 'package:open_work_flutter/view/home/widgets/destination.dart';

abstract class DestinationConverter {
  static List<NavigationRailDestination> asRails(
      List<Destination> destination) {
    return destination
        .map((e) => NavigationRailDestination(
              icon: Icon(e.icon),
              label: Text(e.label),
            ))
        .toList();
  }

  static List<NavigationDestination> asBottoms(List<Destination> destination) {
    return destination
        .map((e) => NavigationDestination(
              icon: Icon(e.icon),
              label: e.label,
            ))
        .toList();
  }
}
