import 'package:quotation/src/store/state/app_state.dart';
import 'package:redux/redux.dart';

class DataGridViewModel {
  final List<Map<String, dynamic>>? rowData;
  DataGridViewModel({this.rowData});
  static DataGridViewModel fromStore(Store<AppState> store) {
    return DataGridViewModel(rowData: store.state.dataGridState.rowData);
  }
}

// login: (email, password) {
// store.dispatch(new ValidateLoginFields(email, password));
// },