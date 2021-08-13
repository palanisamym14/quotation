import 'package:quotation/src/store/state/app_state.dart';
import 'package:quotation/src/store/reducer/reducer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:redux/redux.dart';

Future<Store<AppState>> createStore() async {
  var prefs = await SharedPreferences.getInstance();
  return Store(
    appReducer,
    initialState: AppState.initial(),
    middleware: [],
  );
}
