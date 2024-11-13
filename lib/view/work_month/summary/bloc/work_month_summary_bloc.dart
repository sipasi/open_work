import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_work_flutter/data/summaries/month_summary.dart';
import 'package:open_work_flutter/data/summaries/summary_model.dart';
import 'package:open_work_flutter/storage/month_storage.dart';

part 'work_month_summary_event.dart';
part 'work_month_summary_state.dart';

class WorkMonthSummaryBloc
    extends Bloc<WorkMonthSummaryEvent, WorkMonthSummaryState> {
  WorkMonthSummaryBloc({
    required MonthStorage monthStorage,
  }) : super(WorkMonthSummaryState.empty()) {
    on<WorkMonthSummaryLoadRequested>((event, emit) async {
      final month = await monthStorage.getBy(event.monthId);

      final summary = const MonthSummary();

      final model = summary.create(month!);

      emit(WorkMonthSummaryState(model));
    });
  }
}
