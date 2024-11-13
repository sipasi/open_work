import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/data/summaries/summary_for.dart';
import 'package:open_work_flutter/data/summaries/summary_model.dart';
import 'package:open_work_flutter/storage/month_storage.dart';

part 'settings_summary_state.dart';

class SettingsSummaryCubit extends Cubit<SettingsSummaryState> {
  final MonthStorage monthStorage;
  final SummaryFor<List<WorkMonth>> summary;

  SettingsSummaryCubit({
    required this.monthStorage,
    required this.summary,
  }) : super(SettingsSummaryState.empty());

  Future load() async {
    final months = await monthStorage.getAll();

    final model = summary.create(months);

    emit(SettingsSummaryState(model));
  }
}
