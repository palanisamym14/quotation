import 'package:flutter/material.dart';

@immutable
class DataGridState {
  final List<Map<String, dynamic>>? rowData;
  final Map<String, dynamic>? customerDetail;
  final Map<String, dynamic>? summaryData;
  final String? quotationId;
  DataGridState(
      {this.rowData, this.customerDetail, this.summaryData, this.quotationId});

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
}
