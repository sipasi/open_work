// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/theme/theme_extension.dart';
import 'package:open_work_flutter/view/shared/layouts/separated_column.dart';
import 'package:open_work_flutter/view/shared/layouts/separated_column_section.dart';
import 'package:open_work_flutter/view/work_month/summary/type_summary_view.dart';

import '../../shared/futures/future_view.dart';
import 'work_month_edit_view_model.dart';

class WorkMonthEditPage extends StatefulWidget {
  final WorkMonth month;

  const WorkMonthEditPage({super.key, required this.month});

  @override
  State<WorkMonthEditPage> createState() => _WorkMonthEditPageState();
}

class _WorkMonthEditPageState extends State<WorkMonthEditPage> {
  final DateFormat _dayFormat = DateFormat.MMMM();

  late final WorkMonthEditViewModel viewmodel;

  @override
  void initState() {
    super.initState();

    viewmodel = WorkMonthEditViewModel(
      month: widget.month,
      monthStorage: GetIt.I.get(),
      typeStorage: GetIt.I.get(),
    )..init();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final scheem = context.colorScheme;

    final title = textTheme.headlineMedium;
    final removedTitle = title?.copyWith(color: context.colorScheme.error);

    final templates = viewmodel.templates;
    final supported = viewmodel.supported;
    final supportedDeleted = viewmodel.supportedDeleted;

    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${_dayFormat.format(widget.month.date)} - ${widget.month.days.length}'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => viewmodel.onSave(context),
        label: const Text('Save'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 75),
        child: SeparatedColumn(
          separator: (context, index) => const SizedBox(height: 20),
          children: [
            FutureView(
              future: viewmodel.canBeAddedLoading,
              success: (context, _) {
                if (templates.isEmpty) {
                  return Container();
                }

                return SeparatedColumnSection(
                  title: Text('Can be addedd', style: title),
                  length: templates.length,
                  builder: (index) {
                    final pair = viewmodel.templates[index];

                    onTap() => setState(() => viewmodel.onTamplateTap(index));

                    return ListTile(
                      title: Text(pair.type.name),
                      subtitle: Text(pair.type.price.toString()),
                      selected: pair.selected,
                      trailing: Checkbox(
                        value: pair.selected,
                        onChanged: (value) => onTap(),
                      ),
                      onTap: onTap,
                    );
                  },
                );
              },
            ),
            if (supported.isNotEmpty)
              SeparatedColumnSection(
                title: Text('Supported', style: title),
                length: supported.length,
                builder: (index) {
                  final pair = supported[index];

                  onTap() => viewmodel
                      .onSupportedTap(context, index)
                      .then((value) => setState(() {}));

                  final Widget tile = switch (pair) {
                    SupportedType _ => TypeSummaryTile(
                        info: pair.info,
                        trailing: const Icon(Icons.delete),
                        onTap: onTap,
                      ),
                    TemplateType _ => ListTile(
                        title: Text(pair.type.name),
                        subtitle: Text(pair.type.price.toString()),
                        trailing: const Icon(Icons.remove),
                        onTap: onTap,
                      ),
                    _ => const Text('error')
                  };

                  return tile;
                },
              ),
            if (supportedDeleted.isNotEmpty)
              SeparatedColumnSection(
                title: Text('Removed on save', style: removedTitle),
                length: supportedDeleted.length,
                builder: (index) {
                  final pair = viewmodel.supportedDeleted[index];

                  return TypeSummaryTile(
                    info: pair.info,
                    trailing: const Icon(Icons.restore_page_outlined),
                    subtitleStyle: textTheme.bodyMedium?.copyWith(
                      color: scheem.error,
                    ),
                    onTap: () => setState(
                      () => viewmodel.onDeletedTap(index),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
