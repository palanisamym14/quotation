class SaveRowDataAction {
  final Map<String, dynamic> rowData;
  final int index;
  SaveRowDataAction({required this.rowData, this.index = -1});
}

class UpdateCustomerDetailAction {
  final Map<String, dynamic>? customerDetail;
  UpdateCustomerDetailAction(this.customerDetail);
}

class UpdateSummaryDataAction {
  final Map<String, dynamic>? summaryData;
  UpdateSummaryDataAction(this.summaryData);
}

class UpdateQuotationIdDataAction {
  final String? quotationId;
  UpdateQuotationIdDataAction(this.quotationId);
}

class UpdateGridData {
  final List<Map<String, dynamic>>? gridData;
  final Map<String, dynamic>? summaryDetail;
  final Map<String, dynamic>? customerDetail;
  UpdateGridData({this.gridData, this.customerDetail, this.summaryDetail});
}
