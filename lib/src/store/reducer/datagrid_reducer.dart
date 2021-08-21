import 'package:quotation/src/store/actions/datagrid_action.dart';
import 'package:quotation/src/store/state/datagrid_state.dart';
import 'package:redux/redux.dart';

final dataGridReducer = combineReducers<DataGridState>([
  TypedReducer<DataGridState, SaveRowDataAction>(addGridDataReducer),
  TypedReducer<DataGridState, UpdateCustomerDetailAction>(
      updateCustomerInfoReducer),
  TypedReducer<DataGridState, UpdateSummaryDataAction>(updateSummaryReducer),
  TypedReducer<DataGridState, UpdateQuotationIdDataAction>(
      updateQuotationIdReducer),
  TypedReducer<DataGridState, UpdateGridData>(updateGridData),
]);

DataGridState addGridDataReducer(
    DataGridState state, SaveRowDataAction action) {
  return state.updateRowData(data: action.rowData, index: action.index);
}

DataGridState updateCustomerInfoReducer(
    DataGridState state, UpdateCustomerDetailAction action) {
  return state.copyWith(customerDetail: action.customerDetail);
}

DataGridState updateSummaryReducer(
    DataGridState state, UpdateSummaryDataAction action) {
  return state.copyWith(summaryData: action.summaryData);
}

DataGridState updateQuotationIdReducer(
    DataGridState state, UpdateQuotationIdDataAction action) {
  if (state.quotationId != action.quotationId) {
    var _tempState = DataGridState.initial();
    return state.copyWith(
        customerDetail: _tempState.customerDetail,
        summaryData: _tempState.summaryData,
        rowData: _tempState.rowData,
        quotationId: action.quotationId);
  }
  return state.copyWith(quotationId: action.quotationId);
}

DataGridState updateGridData(DataGridState state, UpdateGridData action) {
  print(action.gridData);
  print("gridData");
  return state.copyWith(
      summaryData: action.summaryDetail,
      customerDetail: action.customerDetail,
      rowData:action.gridData);
}
