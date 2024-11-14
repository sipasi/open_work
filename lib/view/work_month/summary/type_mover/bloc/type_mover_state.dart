part of 'type_mover_bloc.dart';

enum MoveStatus { none, moved }

class DateWrapper extends Equatable {
  final int id;
  final DateTime date;

  const DateWrapper(this.id, this.date);

  @override
  List<Object?> get props => [id];
}

final class TypeMoverState {
  final int monthId;

  final WorkUnit unit;
  final List<DateWrapper> dates;

  final List<WorkType> supportedToMove;

  final WorkType moveFrom;
  final WorkType moveTo;
  final Set<DateWrapper> moveDates;

  final MoveStatus moveStatus;

  bool get moved => moveStatus == MoveStatus.moved;

  TypeMoverState({
    required this.monthId,
    required this.unit,
    required this.dates,
    required this.moveFrom,
    required this.moveTo,
    required this.moveDates,
    required this.supportedToMove,
    required this.moveStatus,
  });

  factory TypeMoverState.initial({
    required int monthId,
    required WorkType moveFrom,
    required UnitDaysPairs pairs,
    required List<WorkType> supportedToMove,
  }) {
    final supported = supportedToMove.toList()
      ..remove(moveFrom)
      ..removeWhere((element) => element.calculation != moveFrom.calculation);

    return TypeMoverState(
      monthId: monthId,
      unit: pairs.unit,
      dates: List.generate(
        pairs.dates.length,
        (index) => DateWrapper(index, pairs.dates[index]),
      ),
      moveFrom: moveFrom,
      moveTo: supported.isEmpty ? moveFrom : supported.first,
      moveDates: {},
      supportedToMove: supported,
      moveStatus: MoveStatus.none,
    );
  }

  TypeMoverState copyWith({
    WorkInfo? info,
    UnitDaysPairs? pairs,
    WorkUnit? unit,
    List<DateWrapper>? dates,
    List<WorkType>? supportedTypes,
    WorkType? moveFrom,
    WorkType? moveTo,
    Set<DateWrapper>? moveDates,
    MoveStatus? moveStatus,
  }) {
    return TypeMoverState(
      monthId: monthId,
      unit: unit ?? this.unit,
      dates: dates ?? this.dates,
      moveFrom: moveFrom ?? this.moveFrom,
      moveTo: moveTo ?? this.moveTo,
      moveDates: moveDates ?? this.moveDates.toSet(),
      supportedToMove: supportedTypes ?? supportedToMove,
      moveStatus: moveStatus ?? this.moveStatus,
    );
  }
}
