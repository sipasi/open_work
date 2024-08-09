import 'package:flutter/material.dart';

class TableBuilder {
  static Table columns<T>({
    required int count,
    required List<T> elements,
    required Widget Function(T data) builder,
    Widget empty = const Text('-', textAlign: TextAlign.center),
    TableBorder? border,
    EdgeInsetsGeometry padding = const EdgeInsets.all(10.0),
  }) =>
      _TableColumnData<T>(
        columns: count,
        elements: elements,
        builder: builder,
        empty: empty,
        border: border,
        padding: padding,
      ).build(
        count: count,
      );
}

class _TableColumnData<T> {
  final int columns;
  final List<T> elements;
  final Widget Function(T data) builder;
  final Widget empty;
  final TableBorder? border;
  final EdgeInsetsGeometry padding;

  _TableColumnData({
    required this.columns,
    required this.elements,
    required this.builder,
    required this.empty,
    required this.border,
    required this.padding,
  });
}

extension _ColumnDataExtension<T> on _TableColumnData<T> {
  Table build({int count = 3}) {
    return Table(
      border: border,
      children: rows(),
    );
  }

  List<TableRow> rows() {
    List<TableRow> result = [];

    int rows = getRowCount(length: elements.length, columns: columns);

    for (var i = 0; i < rows; i++) {
      int from = i * columns;

      final tableRow = row(start: from);

      result.add(tableRow);
    }

    return result;
  }

  TableRow row({required int start}) {
    List<Widget> widgets = <Widget>[];

    for (var col = 0, from = start; col < columns; col++, from++) {
      bool end = from >= elements.length;

      final text = end ? empty : builder(elements[from]);

      final cell = TableCell(
        child: Padding(
          padding: padding,
          child: text,
        ),
      );

      widgets.add(cell);
    }

    return TableRow(children: widgets);
  }

  static int getRowCount({required int length, required int columns}) {
    int rows = (length ~/ columns);

    if (length % columns != 0) {
      rows++;
    }

    return rows;
  }
}
