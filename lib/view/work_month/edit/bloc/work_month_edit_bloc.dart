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
  WorkMonthEditBloc({
    required MonthStorage monthStorage,
    required TypeStorage typeStorage,
  }) : super(WorkMonthEditState.empty()) {
    on<WorkMonthEditLoadRequested>((event, emit) async {
      final month = await monthStorage.getBy(event.id);

      int pairId = 0;

      final templates = (await typeStorage.getAll())
          .where((element) => month!.types.contains(element) == false)
          .map((e) => TemplateType(pairId++, e))
          .toList();

      final supported = month!
          .summarizeTypes()
          .map((e) => SupportedType(pairId++, e))
          .toList();

      emit(state.copyWith(
        id: event.id,
        templates: templates,
        supported: supported,
      ));
    });

    on<WorkMonthEditSaveRequested>((event, emit) async {
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
    });

    on<WorkMonthEditTamplatePressed>((event, emit) {
      final newState = state.deepCopy();

      final template = newState.templates[event.index];

      template.selected
          ? newState.supported.remove(template)
          : newState.supported.add(template);

      newState.templates[event.index] = template.revertSelected();

      emit(newState);
    });
    on<WorkMonthEditSupportedPressed>((event, emit) {
      final newState = state.deepCopy();

      final info = newState.supported[event.index];

      if (info is SupportedType) {
        newState.supported.remove(info);

        newState.removed.add(info);
      } else if (info is TemplateType) {
        newState.supported.remove(info);

        final templateIndex = newState.templates.indexOf(info);

        newState.templates[templateIndex] = info.copyWithSelected(false);
      }

      emit(newState);
    });
    on<WorkMonthEditRemovedPressed>((event, emit) {
      final newState = state.deepCopy();

      final info = newState.removed.removeAt(event.index);

      newState.supported.add(info);

      emit(newState);
    });
  }
}
