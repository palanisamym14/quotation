import 'package:quotation/src/store/actions/app_action.dart';
import 'package:quotation/src/store/state/app_state.dart';
import 'package:redux/redux.dart';

class DataGridViewModel {
  final List<Map<String, dynamic>>? rowData;
  final Function(List<Map<String, dynamic>>? rowData)? addRowData;
  final Function(Map<String, dynamic>? rowData)? updateCustomer;
  final Function(Map<String, dynamic>? rowData)? updateSummary;
  final Function(String)? updateQuotationId;
  final String? quotationId;

  DataGridViewModel(
      {this.rowData,
      this.addRowData,
      this.updateSummary,
      this.updateCustomer,
      this.updateQuotationId,
      this.quotationId});
  static DataGridViewModel fromStore(Store<AppState> store) {
    return DataGridViewModel(
      rowData: store.state.dataGridState.rowData,
      addRowData: (value) => store.dispatch(
        new SaveRowDataAction(rowData: value),
      ),
      updateCustomer: (value) => store.dispatch(
        new SaveRowDataAction(customerDetail: value),
      ),
      updateSummary: (value) => store.dispatch(
        new SaveRowDataAction(summaryData: value),
      ),
      updateQuotationId: (value) => store.dispatch(
        new SaveRowDataAction(quotationId: value),
      ),
    );
  }
}

// login: (email, password) {
// store.dispatch(new ValidateLoginFields(email, password));
// },
