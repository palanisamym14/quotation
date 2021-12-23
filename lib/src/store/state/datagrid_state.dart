import 'package:flutter/material.dart';

@immutable
class DataGridState {
  final List<Map<String, dynamic>> rowData;
  final Map<String, dynamic>? customerDetail;
  final Map<String, dynamic>? summaryData;
  final String? quotationId;
  DataGridState(
      {this.rowData: const [],
      this.customerDetail,
      this.summaryData,
      this.quotationId});

  factory DataGridState.initial() {
    return new DataGridState(
        rowData: [], customerDetail: {}, summaryData: {}, quotationId: '');
  }
  DataGridState copyWith({
    List<Map<String, dynamic>>? rowData,
    Map<String, dynamic>? customerDetail,
    Map<String, dynamic>? summaryData,
    String? quotationId,
  }) {
    return new DataGridState(
        rowData: rowData ?? this.rowData,
        customerDetail: customerDetail ?? this.customerDetail,
        summaryData: summaryData ?? this.summaryData,
        quotationId: quotationId ?? this.quotationId);
  }

  DataGridState updateRowData(
      {required Map<String, dynamic> data, int index = -1}) {
    try {
      if (index > -1 &&
          this.rowData.length > 0 &&
          index < this.rowData.length) {
        this.rowData[index] = data;
      } else {
        this.rowData.add(data);
      }
      var tempVal = this
          .rowData
          .map((e) => double.parse(e["totalPrice"]))
          .reduce((a, b) => a + b);
      this.summaryData!["netPay"] =
          tempVal - (this.summaryData!["discount"] ?? 0);
      this.summaryData!['grandTotal'] = tempVal;
    } on Exception catch (error) {
      print(error);
    }
    return copyWith();
  }
}
