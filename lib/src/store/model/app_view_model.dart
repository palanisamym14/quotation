import 'package:quotation/src/store/actions/datagrid_action.dart';
import 'package:quotation/src/store/actions/menu_action.dart';
import 'package:quotation/src/store/state/app_state.dart';
import 'package:quotation/src/store/state/menu_state.dart';
import 'package:redux/redux.dart';

class AppViewModel {
  final bool hideAppBar;
  AppViewModel({this.hideAppBar: false});
  static AppViewModel fromStore(Store<AppState> store) {
    return AppViewModel(hideAppBar: !store.state.menuState.isVisible);
  }
}

// login: (email, password) {
// store.dispatch(new ValidateLoginFields(email, password));
// },
