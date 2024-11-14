// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/services/navigation/material_navigator.dart';
import 'package:open_work_flutter/theme/theme_extension.dart';
import 'package:open_work_flutter/view/shared/layouts/separated_column.dart';
import 'package:open_work_flutter/view/shared/layouts/separated_column_section.dart';
import 'package:open_work_flutter/view/work_month/edit/bloc/work_month_edit_bloc.dart';
import 'package:open_work_flutter/view/work_month/edit/data/supported_type.dart';
import 'package:open_work_flutter/view/work_month/edit/data/template_type.dart';
import 'package:open_work_flutter/view/work_month/edit/widgets/work_month_edit_dialog.dart';
import 'package:open_work_flutter/view/work_month/shared/widgets/work_unit_formula.dart';

class WorkMonthEditPage extends StatelessWidget {
  final WorkMonth month;

  const WorkMonthEditPage({super.key, required this.month});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WorkMonthEditBloc(
        monthStorage: GetIt.I.get(),
        typeStorage: GetIt.I.get(),
      )..add(WorkMonthEditLoadRequested(month.id!)),
      child: WorkMonthEditView(
        id: month.id!,
        date: month.date,
        daysInMonth: month.days.length,
      ),
    );
  }
}

class WorkMonthEditView extends StatelessWidget {
  static final DateFormat _monthFormat = DateFormat.MMMM();

  final int id;
  final DateTime date;
  final int daysInMonth;

  const WorkMonthEditView({
    super.key,
    required this.id,
    required this.date,
    required this.daysInMonth,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    final templateTitle = textTheme.titleMedium?.copyWith(
      color: colorScheme.secondary,
      fontWeight: FontWeight.bold,
    );
    final supportedTitle = templateTitle?.copyWith(
      color: colorScheme.primary,
    );
    final removedTitle = templateTitle?.copyWith(
      color: colorScheme.error,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('${_monthFormat.format(date)} - $daysInMonth'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _bloc(context).add(WorkMonthEditSaveRequested(id));
        },
        label: const Text('Save'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 75),
        child: BlocConsumer<WorkMonthEditBloc, WorkMonthEditState>(
          listener: (context, state) async {
            if (state.navigationState == NavigationState.pop) {
              final result = await WorkMonthEditDialog.changesOnSave(
                context: context,
                removed: state.removed,
                added: state.supported.whereType<TemplateType>().toList(),
              );

              if (context.mounted && result) MaterialNavigator.pop(context);
            }
          },
          builder: (context, state) {
            return SeparatedColumn(
              separator: (context, index) => const SizedBox(height: 20),
              children: [
                if (state.templates.isNotEmpty)
                  SeparatedColumnSection(
                    title: Text('Templates', style: templateTitle),
                    length: state.templates.length,
                    builder: (index) => _templateBuilder(context, index),
                  ),
                if (state.supported.isNotEmpty)
                  SeparatedColumnSection(
                    title: Text('Supported', style: supportedTitle),
                    length: state.supported.length,
                    builder: (index) => _supportedBuilder(context, index),
                  ),
                if (state.removed.isNotEmpty)
                  SeparatedColumnSection(
                    title: Text('Removed on save', style: removedTitle),
                    length: state.removed.length,
                    builder: (index) => _removeBuilder(context, index),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _templateBuilder(BuildContext context, int index) {
    final state = _bloc(context).state;

    final pair = state.templates[index];

    return ListTile(
      title: Text(pair.type.name),
      subtitle: Text(pair.type.price.toString()),
      trailing: pair.selected
          ? Icon(Icons.check_box_outlined)
          : Icon(Icons.check_box_outline_blank),
      textColor: context.colorScheme.secondary,
      selected: pair.selected,
      onTap: () => _bloc(context).add(WorkMonthEditTamplatePressed(index)),
    );
  }

  Widget _supportedBuilder(BuildContext context, int index) {
    final state = _bloc(context).state;

    final pair = state.supported[index];

    final Widget tile = switch (pair) {
      SupportedType _ => ListTile(
          title: Text(pair.type.name),
          trailing: const Icon(Icons.delete),
          textColor: context.colorScheme.primary,
          subtitle: WorkUnitFormula.auto(
            type: pair.type,
            units: pair.units,
          ),
          onTap: () => _onSupportedTap(context, index),
        ),
      TemplateType _ => ListTile(
          title: Text(pair.type.name),
          subtitle: Text(pair.type.price.toString()),
          trailing: const Icon(Icons.remove),
          textColor: context.colorScheme.secondary,
          onTap: () => _onSupportedTap(context, index),
        ),
      _ => const Text('error')
    };

    return tile;
  }

  Widget _removeBuilder(BuildContext context, int index) {
    final state = _bloc(context).state;

    final pair = state.removed[index];

    return ListTile(
      trailing: const Icon(Icons.restore_page_outlined),
      title: Text(pair.type.name),
      subtitle: WorkUnitFormula.auto(type: pair.type, units: pair.units),
      onTap: () => _bloc(context).add(WorkMonthEditRemovedPressed(index)),
    );
  }

  Future _onSupportedTap(BuildContext context, int index) async {
    final info = _bloc(context).state.supported[index];

    if (info is SupportedType) {
      bool result = await WorkMonthEditDialog.deleteSupportedType(
        context: context,
        type: info,
      );

      if (result == false) {
        return;
      }
    }
    if (context.mounted) {
      _bloc(context).add(WorkMonthEditSupportedPressed(index));
    }
  }

  WorkMonthEditBloc _bloc(BuildContext context) =>
      context.read<WorkMonthEditBloc>();
}
