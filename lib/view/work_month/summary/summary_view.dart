import 'package:flutter/material.dart';
import 'package:open_work_flutter/data/summaries/summary_model.dart';
import 'package:open_work_flutter/view/work_month/summary/type_summary_view.dart';
import 'package:open_work_flutter/view/work_month/summary/work_summary_view.dart';

class SummaryView extends StatelessWidget {
  final SummaryModel summary;

  const SummaryView({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Card.outlined(
          child: TypeSummaryView(
            summary: summary.types,
            builder: (info, index) {
              return TypeSummaryTile(
                info: info,
                leading: const Icon(Icons.type_specimen_outlined),
                trailing: Text(info.units.length.toString()),
              );
            },
          ),
        ),
        Card.outlined(
          child: WorkSummaryView(summary: summary.works),
        ),
      ],
    );
  }
}
