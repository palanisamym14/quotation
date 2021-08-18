import 'package:quotation/src/store/actions/datagrid_action.dart';
import 'package:quotation/src/store/actions/menu_action.dart';
import 'package:quotation/src/store/state/app_state.dart';
import 'package:quotation/src/store/state/menu_state.dart';
import 'package:redux/redux.dart';

class NavigationViewModel {
  final bool isHidden;
  final Function? showAppBar;
  final Function? hideAppBar;

  NavigationViewModel({this.isHidden: false, this.hideAppBar, this.showAppBar});
  static NavigationViewModel fromStore(Store<AppState> store) {
    return NavigationViewModel(
      isHidden: !store.state.menuState.isVisible,
      showAppBar: () => store.dispatch(
        new ShowAppBarAction(),
      ),
      hideAppBar: () => store.dispatch(
        new HideAppBarAction(),
      ),
    );
  }
}

// login: (email, password) {
// store.dispatch(new ValidateLoginFields(email, password));
// },
