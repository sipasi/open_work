import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_work_flutter/data/summaries/month_summary_extension.dart';
import 'package:open_work_flutter/storage/month_storage.dart';
import 'package:open_work_flutter/storage/type_storage.dart';
import 'package:open_work_flutter/view/work_month/edit/data/pair_type.dart';
import 'package:open_work_flutter/view/work_month/edit/data/supported_type.dart';
import 'package:open_work_flutter/view/work_month/edit/data/template_type.dart';

part 'work_month_edit_event.dart';
part 'work_month_edit_state.dart';

class WorkMonthEditBloc extends Bloc<WorkMonthEditEvent, WorkMonthEditState> {
  final MonthStorage monthStorage;
  final TypeStorage typeStorage;

  WorkMonthEditBloc({
    required this.monthStorage,
    required this.typeStorage,
  }) : super(WorkMonthEditState.empty()) {
    on<WorkMonthEditLoadRequested>(_onLoadRequested);

    on<WorkMonthEditSaveRequested>(_onSaveRequested);

    on<WorkMonthEditTamplatePressed>(_onTamplatePressed);
    on<WorkMonthEditSupportedPressed>(_onSupportedPressed);
    on<WorkMonthEditRemovedPressed>(_onRemovedPressed);
  }

  Future _onLoadRequested(
    WorkMonthEditLoadRequested event,
    Emitter<WorkMonthEditState> emit,
  ) async {
    final month = await monthStorage.getBy(event.id);

    if (month == null) {
      return;
    }

    int pairId = 0;

    final templates = (await typeStorage.getAll())
        .where((element) => month.types.contains(element) == false)
        .map((e) => TemplateType(pairId++, e))
        .toList();

    final supported = month
        .summarizeTypes()
        .map(
          (e) => SupportedType(pairId++, e),
        )
        .toList();

    emit(state.copyWith(
      id: event.id,
      templates: templates,
      supported: supported,
    ));
  }

  Future _onSaveRequested(
    WorkMonthEditSaveRequested event,
    Emitter<WorkMonthEditState> emit,
  ) async {
    final typesToDeleted =
        state.removed.map((e) => e.type).toList(growable: false);

    final typesToAdd =
        state.supported.whereType<TemplateType>().map((e) => e.type);

    final month = await monthStorage.getBy(event.id);

    for (var day in month!.days) {
      day.works.removeWhere(
        (work) => typesToDeleted.contains(work.type),
      );
    }

    month.types.removeWhere(
      (type) => typesToDeleted.contains(type),
    );

    month.types.addAll(typesToAdd);

    await monthStorage.updateOrCreate(month);

    emit(state.copyWith(navigationState: NavigationState.pop));
  }

  void _onTamplatePressed(
    WorkMonthEditTamplatePressed event,
    Emitter<WorkMonthEditState> emit,
  ) {
    final newState = state.deepCopy();

    final template = newState.templates[event.index];

    template.selected
        ? newState.supported.remove(template)
        : newState.supported.add(template);

    newState.templates[event.index] = template.revertSelected();

    emit(newState);
  }

  void _onSupportedPressed(
    WorkMonthEditSupportedPressed event,
    Emitter<WorkMonthEditState> emit,
  ) {
    final newState = state.deepCopy();

    final PairType type = newState.supported[event.index];

    if (type is SupportedType) {
      newState.supported.remove(type);

      newState.removed.add(type);
    } else if (type is TemplateType) {
      newState.supported.remove(type);

      final templateIndex = newState.templates.indexOf(type);

      newState.templates[templateIndex] = type.copyWithSelected(false);
    }

    emit(newState);
  }

  void _onRemovedPressed(
    WorkMonthEditRemovedPressed event,
    Emitter<WorkMonthEditState> emit,
  ) {
    final newState = state.deepCopy();

    final info = newState.removed.removeAt(event.index);

    newState.supported.add(info);

    emit(newState);
  }
}
