import 'package:flutter/material.dart';

class mDataTable extends StatelessWidget {
  final List<String> columns;
  final List<DataRow> rows;
  const mDataTable({super.key, required this.columns, required this.rows});

  @override
  Widget build(BuildContext context) {
    return DataTable(
        columns: columns.map((e) => DataColumn(
        label: Text(e)),).toList(),
        rows: rows
    );
  }
}
