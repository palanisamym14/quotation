class SaveRowDataAction {
  final List<Map<String, dynamic>>? rowData;
  final Map<String, dynamic>? customerDetail;
  final Map<String, dynamic>? summaryData;
  final String? quotationId;
  SaveRowDataAction(
      {this.rowData, this.customerDetail, this.summaryData, this.quotationId});
}
