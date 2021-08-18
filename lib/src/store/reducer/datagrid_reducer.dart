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
]);

DataGridState addGridDataReducer(
    DataGridState state, SaveRowDataAction action) {
  return state.updateRowData(data: action.rowData, index: action.index);
}

DataGridState updateCustomerInfoReducer(
    DataGridState state, UpdateCustomerDetailAction action) {
  print("customerDetail");
  print(action.customerDetail);
  return state.copyWith(customerDetail: action.customerDetail);
}

DataGridState updateSummaryReducer(
    DataGridState state, UpdateSummaryDataAction action) {
  print(action.summaryData);
  return state.copyWith(summaryData: action.summaryData);
}

DataGridState updateQuotationIdReducer(
    DataGridState state, UpdateQuotationIdDataAction action) {
  return state.copyWith(quotationId: action.quotationId);
}
