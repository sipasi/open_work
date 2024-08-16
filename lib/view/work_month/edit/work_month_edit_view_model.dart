// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/data/models/work_type.dart';
import 'package:open_work_flutter/data/models/work_unit.dart';
import 'package:open_work_flutter/data/summaries/summary_model.dart';
import 'package:open_work_flutter/services/navigation/material_navigator.dart';
import 'package:open_work_flutter/services/result.dart';
import 'package:open_work_flutter/storage/month_storage.dart';
import 'package:open_work_flutter/storage/type_storage.dart';
import 'package:open_work_flutter/theme/theme_extension.dart';
import 'package:open_work_flutter/view/shared/dialogs/delete_dialog.dart';

import '../../../data/summaries/month_summary_extension.dart';

class WorkMonthEditViewModel {
  final DateFormat dayFormat = DateFormat.MMMM();

  final TypeStorage typeStorage;
  final MonthStorage monthStorage;

  final WorkMonth month;

  final List<TemplateType> templates;
  final List<PairType> supported;
  final List<SupportedType> supportedDeleted;

  Future? _templatesLoading;

  Future get canBeAddedLoading => _templatesLoading ?? Future.value();

  WorkMonthEditViewModel({
    required WorkMonth month,
    required this.monthStorage,
    required this.typeStorage,
  })  : month = WorkMonth.fromJson(month.toJson()),
        supported = [],
        supportedDeleted = [],
        templates = [];

  void init() {
    _templatesLoading = GetIt.I.get<TypeStorage>().getAll().then((value) {
      templates.addAll(
        value
            .where((element) => !month.types.contains(element))
            .map(TemplateType.new),
      );
    });

    supported.addAll(month.summarizeTypes().map((e) {
      return SupportedType(e);
    }));
  }

  void onTamplateTap(int index) {
    final info = templates[index];

    info.selected ? supported.remove(info) : supported.add(info);

    info.revertSelected();
  }

  Future onSupportedTap(BuildContext context, int index) async {
    final info = supported[index];

    if (info is SupportedType) {
      bool result = await DeleteDialog.showMessage(
        context: context,
        title: info.type.name,
        message: 'Do you want to delete all records on sum of ${info.sum}',
      );

      if (result == false) {
        return;
      }

      supported.remove(info);

      supportedDeleted.add(info);

      return;
    }

    if (info is TemplateType) {
      supported.remove(info);
      info.revertSelected();
    }
  }

  void onDeletedTap(int index) {
    final info = supportedDeleted[index];

    supportedDeleted.removeAt(index);

    supported.add(info);
  }

  Future onSave(BuildContext context) async {
    final typesToDeleted =
        supportedDeleted.map((e) => e.type).toList(growable: false);

    final typesToAdd = supported.whereType<TemplateType>().map((e) => e.type);

    if (await _monthSaveDialog(context) == false) {
      return;
    }

    for (var day in month.days) {
      day.works.removeWhere(
        (work) => typesToDeleted.contains(work.type),
      );
    }

    month.types.removeWhere(
      (type) => typesToDeleted.contains(type),
    );

    month.types.addAll(typesToAdd);

    await monthStorage.updateOrCreate(month);

    if (context.mounted) {
      MaterialNavigator.popWith(context, CrudResult.modify(month));
    }
  }

  Future<bool> _monthSaveDialog(BuildContext context) {
    final deletedStyle = context.textTheme.bodyMedium?.copyWith(
      color: context.colorScheme.error,
    );
    final addedStyle = context.textTheme.bodyMedium?.copyWith(
      color: context.colorScheme.primary,
    );

    return DeleteDialog.show(
      context: context,
      title: 'Changes',
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...supportedDeleted.map((e) {
              final name = e.type.name;
              final price = e.type.price.toString();

              return Text('- $name $price', style: deletedStyle);
            }),
            const SizedBox(height: 4),
            ...supported.whereType<TemplateType>().map(
              (e) {
                final name = e.type.name;
                final price = e.type.price.toString();

                return Text('+ $name $price', style: addedStyle);
              },
            ),
          ],
        ),
      ),
    );
  }
}

abstract class PairType {
  WorkType get type;

  PairType();
}

class SupportedType extends PairType {
  final TypeInfo info;

  bool _deleted;

  bool get deleted => _deleted;

  @override
  WorkType get type => info.type;

  int get count => info.count;
  double get sum => info.sum;

  List<WorkUnit> get units => info.units;

  SupportedType(this.info, [this._deleted = false]);

  bool revertDeleted() => _deleted = !_deleted;
}

class TemplateType extends PairType {
  final WorkType _type;

  bool _selected;

  bool get selected => _selected;

  @override
  WorkType get type => _type;

  TemplateType(this._type, [this._selected = false]);

  bool revertSelected() => _selected = !_selected;
}
