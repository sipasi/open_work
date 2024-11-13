import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_work_flutter/data/entity_creator.dart';
import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/storage/month_storage.dart';
import 'package:open_work_flutter/storage/type_storage.dart';

part 'work_month_list_event.dart';
part 'work_month_list_state.dart';

class WorkMonthListBloc extends Bloc<WorkMonthListEvent, WorkMonthListState> {
  WorkMonthListBloc({
    required MonthStorage monthStorage,
    required TypeStorage typeStorage,
  }) : super(WorkMonthListState.empty()) {
    on<WorkMonthListLoadRequested>((event, emit) async {
      final months = await monthStorage.getAll();

      _sortByDate(months);

      emit(state.copyWith(months: months));
    });
    on<WorkMonthListDeleteRequested>((event, emit) async {
      final first = state.months.firstWhere(
        (element) =>
            element.date.year == event.year &&
            element.date.month == event.month,
      );

      await monthStorage.delete(first.id!);

      add(WorkMonthListLoadRequested());
    });
    on<WorkMonthListCreateRequested>((event, emit) async {
      final types = await typeStorage.getAll();

      final entity = EntityCreator.workMonth(
        year: event.year,
        month: event.month,
        types: types,
      );

      await monthStorage.updateOrCreate(entity);

      add(WorkMonthListLoadRequested());
    });
  }

  static void _sortByDate(List<WorkMonth> list) {
    list.sort((first, second) => second.date.compareTo(first.date));
  }
}
