import 'package:quotation/src/store/actions/app_action.dart';
import 'package:quotation/src/store/state/datagrid_state.dart';
import 'package:redux/redux.dart';

final dataGridReducer = combineReducers<DataGridState>([
  TypedReducer<DataGridState, SaveRowDataAction>(addGridDataReducer),
  TypedReducer<DataGridState, SaveRowDataAction>(updateCustomerInfoReducer),
  TypedReducer<DataGridState, SaveRowDataAction>(updateSummaryReducer),
  TypedReducer<DataGridState, SaveRowDataAction>(updateQuotationIdReducer),
]);

DataGridState addGridDataReducer(DataGridState state, SaveRowDataAction action) {
  print("rowData");
  print(action.rowData);
  return state.copyWith(rowData: action.rowData);
}

DataGridState updateCustomerInfoReducer(DataGridState state, SaveRowDataAction action) {
  print("customerDetail");
  print(action.customerDetail);
  return state.copyWith(customerDetail: action.customerDetail);
}


DataGridState updateSummaryReducer(DataGridState state, SaveRowDataAction action) {
  print("state");
  return state.copyWith(summaryData: action.summaryData);
}


DataGridState updateQuotationIdReducer(DataGridState state, SaveRowDataAction action) {
  print("state");
  return state.copyWith(quotationId: action.quotationId);
}


