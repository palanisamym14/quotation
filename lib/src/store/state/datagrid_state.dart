import 'package:flutter/material.dart';

@immutable
class DataGridState {
  final List<Map<String, dynamic>>? rowData;
  final Map<String, dynamic>? companyDetail;
  final Map<String, dynamic>? footerValue;
  DataGridState({
    this.rowData,
    this.companyDetail,
    this.footerValue,
  });

  factory DataGridState.initial() {
    return new DataGridState(rowData: [], companyDetail: {}, footerValue: {});
  }
  DataGridState copyWith({
    List<Map<String, dynamic>>? rowData,
  }) {
    return new DataGridState(
        rowData: rowData ?? this.rowData,
        companyDetail: companyDetail ?? this.companyDetail,
        footerValue: footerValue ?? this.footerValue);
  }
}
