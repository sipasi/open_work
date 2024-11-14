import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_work_flutter/data/models/work.dart';
import 'package:open_work_flutter/data/models/work_day.dart';
import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/data/models/work_type.dart';
import 'package:open_work_flutter/data/models/work_unit.dart';
import 'package:open_work_flutter/data/summaries/summary_model.dart';
import 'package:open_work_flutter/storage/month_storage.dart';

part 'type_mover_event.dart';
part 'type_mover_state.dart';

class TypeMoverBloc extends Bloc<TypeMoverEvent, TypeMoverState> {
  final MonthStorage monthStorage;

  TypeMoverBloc({
    required int monthId,
    required WorkType moveFrom,
    required UnitDaysPairs pairs,
    required List<WorkType> supportedToMove,
    required this.monthStorage,
  }) : super(
          TypeMoverState.initial(
            monthId: monthId,
            moveFrom: moveFrom,
            pairs: pairs,
            supportedToMove: supportedToMove,
          ),
        ) {
    on<TypeMoverMoveToTypeChanged>(_onMoveToTypeChanged);

    on<TypeMoverDateSelected>(_onDateSelected);

    on<TypeMoverMovePressed>(_onMovePressed);
  }

  FutureOr<void> _onMoveToTypeChanged(event, emit) {
    emit(state.copyWith(
      moveTo: event.value,
    ));
  }

  FutureOr<void> _onDateSelected(event, emit) {
    if (state.moveDates.add(event.value) == false) {
      state.moveDates.remove(event.value);
    }
    emit(state.copyWith());
  }

  FutureOr<void> _onMovePressed(event, emit) async {
    final month = await monthStorage.getBy(state.monthId);

    if (month == null ||
        state.moveDates.isEmpty ||
        state.moveFrom == state.moveTo) {
      return;
    }

    _moveUnits(
      month: month,
      unit: state.unit,
      from: state.moveFrom,
      to: state.moveTo,
      moveDates: state.moveDates,
    );

    await monthStorage.updateOrCreate(month);

    emit(state.copyWith(moveStatus: MoveStatus.moved));
  }

  static void _moveUnits({
    required WorkMonth month,
    required WorkUnit unit,
    required WorkType from,
    required WorkType to,
    required Set<DateWrapper> moveDates,
  }) {
    for (var movingDate in moveDates) {
      final dayIndex = movingDate.date.day - 1;

      final day = month.days[dayIndex];

      _removeUnits(
        day: day,
        type: from,
        remove: unit,
      );

      _addUnits(
        day: day,
        type: to,
        add: unit,
      );
    }
  }

  static void _removeUnits({
    required WorkDay day,
    required WorkType type,
    required WorkUnit remove,
  }) {
    final int index = day.works.indexWhere(
      (element) => element.type == type,
    );

    final Work from = day.works[index];

    from.units.remove(remove);

    if (from.units.isEmpty) {
      day.works.removeAt(index);
    }
  }

  static void _addUnits({
    required WorkDay day,
    required WorkType type,
    required WorkUnit add,
  }) {
    final addTo = day.works.firstWhere(
      (element) => element.type == type,
      orElse: () {
        final work = Work(type, []);

        day.works.add(work);

        return work;
      },
    );

    addTo.units.add(add);
  }
}
