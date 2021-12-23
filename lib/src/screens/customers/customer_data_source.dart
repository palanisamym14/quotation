import 'package:flutter/material.dart';
import 'package:quotation/src/screens/dataGrid/grid_constant.draft.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CustomerDataSource extends DataGridSource {
  CustomerDataSource(List<dynamic> customers) {
    dataGridRows = customers
        .map<DataGridRow>((dataGridRow) => DataGridRow(
                cells: new List.generate(
              customerDetailColumns.length,
              (index) {
                var column = customerDetailColumns[index];
                return DataGridCell<String>(
                    columnName: column["label"],
                    value: dataGridRow[column["_key"]].toString());
              },
            ).toList()))
        .toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
          alignment: (dataGridCell.columnName == 'id' ||
                  dataGridCell.columnName == 'salary')
              ? Alignment.centerRight
              : Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            dataGridCell.value.toString(),
            overflow: TextOverflow.ellipsis,
          ));
    }).toList());
  }
}
