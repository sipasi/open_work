part of 'settings_summary_cubit.dart';

final class SettingsSummaryState {
  final SummaryModel model;

  const SettingsSummaryState(this.model);
  const SettingsSummaryState.empty() : this(const SummaryModel.empty());
}
