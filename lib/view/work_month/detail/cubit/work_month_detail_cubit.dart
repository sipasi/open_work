import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_work_flutter/data/models/work_day.dart';
import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/data/models/work_type.dart';
import 'package:open_work_flutter/storage/month_storage.dart';

part 'work_month_detail_state.dart';

class WorkMonthDetailCubit extends Cubit<WorkMonthDetailState> {
  final MonthStorage monthStorage;

  WorkMonthDetailCubit({required this.monthStorage})
      : super(WorkMonthDetailState.empty());

  Future loadAll(int id) async {
    final month = await monthStorage.getBy(id);

    if (month == null) {
      return;
    }

    emit(state.copyWith(month: month));
  }
}
