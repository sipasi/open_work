import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:open_work_flutter/data/models/work_month.dart';
import 'package:open_work_flutter/data/summaries/works_summarizer.dart';
import 'package:open_work_flutter/services/export/formatter/format_options.dart';
import 'package:open_work_flutter/services/export/work_month/work_month_formatter.dart';

class TextFormatter extends WorkMonthFormatter {
  final _yearMonthFormatter = DateFormat(DateFormat.YEAR_MONTH);
  final _dayFormatter = DateFormat(DateFormat.DAY);

  static const WorksSummarizer _worksSummarizer = WorksSummarizer();

  @override
  Future<List<int>> format(List<WorkMonth> data, FormatOptions options) {
    final buffer = StringBuffer();

    for (var element in data) {
      writeWordGroup(buffer, element);
    }

    final text = buffer.toString();

    final bytes = utf8.encode(text);

    return Future.value(bytes);
  }

  void writeWordGroup(StringBuffer buffer, WorkMonth data) {
    buffer.write('date: ');

    buffer.write(_yearMonthFormatter.format(data.date));

    buffer.writeln();

    final worksInfo = _worksSummarizer.summarize(data.days);

    for (var entity in worksInfo) {
      buffer.write(entity.type.name);
      buffer.write('(');
      buffer.write(entity.summaries.length);
      buffer.write(')');

      if (entity.summaries.isNotEmpty) {
        buffer.write(' - ');

        int sum = entity.summaries
            .map((e) => e.dates.length)
            .reduce((value, element) => value + element);

        buffer.write(sum);
      }

      buffer.writeln();

      for (var element in entity.summaries) {
        buffer.write(element.unit.value);

        buffer.write('(');
        buffer.write(element.dates.length);
        buffer.write(')');

        buffer.write(' - ');

        buffer.write(element.dates.map(_dayFormatter.format).join(', '));

        buffer.writeln();
      }

      buffer.writeln();
      buffer.writeln();
    }
  }
}
