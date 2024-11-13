part of 'work_month_edit_bloc.dart';

enum NavigationState { none, pop }

final class WorkMonthEditState {
  final int id;

  final List<TemplateType> templates;
  final List<PairType> supported;
  final List<SupportedType> removed;

  final NavigationState navigationState;

  WorkMonthEditState({
    required this.id,
    required this.templates,
    required this.supported,
    required this.removed,
    this.navigationState = NavigationState.none,
  });

  WorkMonthEditState.empty()
      : id = -1,
        templates = const [],
        supported = const [],
        removed = const [],
        navigationState = NavigationState.none;

  WorkMonthEditState copyWith({
    int? id,
    List<TemplateType>? templates,
    List<PairType>? supported,
    List<SupportedType>? supportedRemoved,
    NavigationState? navigationState,
  }) {
    return WorkMonthEditState(
      id: id ?? this.id,
      templates: templates ?? this.templates.map((e) => e.deepCopy()).toList(),
      supported: supported ?? this.supported.map((e) => e.deepCopy()).toList(),
      removed: supportedRemoved ?? removed.map((e) => e.deepCopy()).toList(),
      navigationState: navigationState ?? this.navigationState,
    );
  }

  WorkMonthEditState deepCopy() {
    return copyWith();
  }
}
