import 'package:quotation/src/store/actions/app_action.dart';
import 'package:quotation/src/store/state/app_state.dart';
import 'package:redux/redux.dart';

class DataGridViewModel {
  final List<Map<String, dynamic>>? rowData;
  final Function(List<Map<String, dynamic>>? rowData)? addRowData;
  final Function(List<Map<String, dynamic>>? rowData)? updateCustomer;
  final Function(List<Map<String, dynamic>>? rowData)? updateSummary;
  final Function(List<Map<String, dynamic>>? rowData)? updateQuotationId;
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
      addRowData: (_rowData) => store.dispatch(
        new SaveRowDataAction(_rowData),
      ),
      updateCustomer: (_rowData) => store.dispatch(
        new SaveRowDataAction(_rowData),
      ),
      updateSummary: (_rowData) => store.dispatch(
        new SaveRowDataAction(_rowData),
      ),
      updateQuotationId: (_rowData) => store.dispatch(
        new SaveRowDataAction(_rowData),
      ),
    );
  }
}

// login: (email, password) {
// store.dispatch(new ValidateLoginFields(email, password));
// },
