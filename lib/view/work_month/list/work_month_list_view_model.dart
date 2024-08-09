import 'package:flutter/material.dart';
import 'package:open_work_flutter/data/entity_creator.dart';
import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/storage/month_storage.dart';
import 'package:open_work_flutter/storage/type_storage.dart';
import 'package:open_work_flutter/view/work_month/detail/work_month_details_page.dart';
import 'package:open_work_flutter/view/work_month/list/month_picker/month_picker.dart';

class WorkMonthListViewModel {
  final TypeStorage typeStorage;
  final MonthStorage monthStorage;

  final List<WorkMonth> entities;

  final Function() stateSetter;

  WorkMonthListViewModel({
    required this.typeStorage,
    required this.monthStorage,
    required this.stateSetter,
  }) : entities = [];

  Future loadAll() async {
    final list = await monthStorage.getAll();

    _sortByDate(list);

    refill(list);
  }

  Future onTap(BuildContext context, int index) async {
    final month = entities[index];

    await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => WorkMonthDetailsPage(month: month)));

    await loadAll();
  }

  Future onCreateTap(BuildContext context) async {
    final types = await typeStorage.getAll();

    var picker = MonthPicker(
      initialYear: DateTime.now().year,
      onYearChanged: (year, months) {
        months.unselectAll();

        if (entities.isEmpty) {
          return;
        }

        final similar = entities.where((element) => element.date.year == year);

        if (similar.isEmpty) {
          return;
        }

        for (final element in similar) {
          final month = months.getBy(element.date.month);

          month.select();
        }
      },
      onMonthSelected: (year, month) {
        month.select();

        final entity = EntityCreator.workMonth(
          year: year,
          month: month.value,
          types: types,
        );

        updateState(() {
          entities.add(entity);
          _sortByDate(entities);
        });

        monthStorage.updateOrCreate(entity);
      },
      onMonthDeleted: (year, month) {
        month.unselect();

        final first = entities.firstWhere(
          (element) =>
              element.date.year == year && element.date.month == month.value,
        );

        updateState(() {
          entities.remove(first);
        });

        monthStorage.delete(first.id!);
      },
    );

    if (context.mounted) {
      await showModalBottomSheet(
        context: context,
        builder: (builder) => picker,
      );
    }
  }

  void refill(List<WorkMonth> list) => entities
    ..clear()
    ..addAll(list);

  void updateState(void Function() action) {
    action();

    stateSetter();
  }

  static void _sortByDate(List<WorkMonth> list) {
    list.sort((first, second) => second.date.compareTo(first.date));
  }
}
