import 'package:quotation/src/store/actions/app_action.dart';
import 'package:quotation/src/store/state/app_state.dart';
import 'package:redux/redux.dart';

class DataGridViewModel {
  final List<Map<String, dynamic>> rowData;
  final Map<String, dynamic>? summaryData;
  final Function(Map<String, dynamic> rowData, int index)? addRowData;
  final Function(Map<String, dynamic> rowData)? updateCustomer;
  final Function(Map<String, dynamic> rowData)? updateSummary;
  final Function(String)? updateQuotationId;
  final String? quotationId;

  DataGridViewModel(
      {this.rowData: const [],
      this.summaryData,
      this.addRowData,
      this.updateSummary,
      this.updateCustomer,
      this.updateQuotationId,
      this.quotationId});
  static DataGridViewModel fromStore(Store<AppState> store) {
    return DataGridViewModel(
      rowData: store.state.dataGridState.rowData,
      summaryData: store.state.dataGridState.summaryData,
      addRowData: (value, index) => store.dispatch(
        new SaveRowDataAction(rowData: value, index: index),
      ),
      updateCustomer: (value) => store.dispatch(
        new UpdateCustomerDetailAction(value),
      ),
      updateSummary: (value) => store.dispatch(
        new UpdateSummaryDataAction(value),
      ),
      updateQuotationId: (value) => store.dispatch(
        new UpdateQuotationIdDataAction(value),
      ),
    );
  }
}

// login: (email, password) {
// store.dispatch(new ValidateLoginFields(email, password));
// },
