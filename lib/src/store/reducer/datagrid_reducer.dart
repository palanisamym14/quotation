import 'package:quotation/src/store/actions/app_action.dart';
import 'package:quotation/src/store/state/datagrid_state.dart';
import 'package:redux/redux.dart';

final dataGridReducer = combineReducers<DataGridState>([
  TypedReducer<DataGridState, SaveRowDataAction>(addGridDataReducer),
  TypedReducer<DataGridState, SaveRowDataAction>(updateCustomerInfoReducer),
  TypedReducer<DataGridState, SaveRowDataAction>(updateSummaryReducer),
]);

DataGridState addGridDataReducer(DataGridState state, SaveRowDataAction action) {
  print("state");
  print(action.data);
  return state.copyWith(rowData: action.data);
}

DataGridState updateCustomerInfoReducer(DataGridState state, SaveRowDataAction action) {
  print("state");
  print(action.data);
  return state.copyWith(rowData: action.data);
}


DataGridState updateSummaryReducer(DataGridState state, SaveRowDataAction action) {
  print("state");
  print(action.data);
  return state.copyWith(rowData: action.data);
}


