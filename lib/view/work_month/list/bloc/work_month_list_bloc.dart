import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_work_flutter/collection/extension/list_sort.dart';
import 'package:open_work_flutter/data/entity_creator.dart';
import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/storage/month_storage.dart';
import 'package:open_work_flutter/storage/type_storage.dart';

part 'work_month_list_event.dart';
part 'work_month_list_state.dart';

class WorkMonthListBloc extends Bloc<WorkMonthListEvent, WorkMonthListState> {
  final MonthStorage monthStorage;
  final TypeStorage typeStorage;

  WorkMonthListBloc({
    required this.monthStorage,
    required this.typeStorage,
  }) : super(WorkMonthListState.empty()) {
    on<WorkMonthListLoadRequested>(_onLoadRequested);
    on<WorkMonthListDeleteRequested>(_onDeleteRequested);
    on<WorkMonthListCreateRequested>(_onCreateRequested);
  }

  Future _onLoadRequested(
    WorkMonthListLoadRequested event,
    Emitter<WorkMonthListState> emit,
  ) async {
    final months = await monthStorage.getAll();

    months.sortDescBy((item) => item.date);

    emit(state.copyWith(months: months));
  }

  Future _onDeleteRequested(
    WorkMonthListDeleteRequested event,
    Emitter<WorkMonthListState> emit,
  ) async {
    final first = state.months.firstWhere(
      (element) =>
          element.date.year == event.year && element.date.month == event.month,
    );

    await monthStorage.delete(first.id!);

    add(WorkMonthListLoadRequested());
  }

  Future _onCreateRequested(
    WorkMonthListCreateRequested event,
    Emitter<WorkMonthListState> emit,
  ) async {
    final types = await typeStorage.getAll();

    final entity = EntityCreator.workMonth(
      year: event.year,
      month: event.month,
      types: types,
    );

    await monthStorage.updateOrCreate(entity);

    add(WorkMonthListLoadRequested());
  }
}
