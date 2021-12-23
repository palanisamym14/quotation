import 'package:quotation/src/store/state/app_state.dart';
import 'package:quotation/src/store/reducer/reducer.dart';
// import 'package:redux_remote_devtools/redux_remote_devtools.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:redux/redux.dart';

Future<Store<AppState>> createStore() async {
  // var remoteDevtools = RemoteDevToolsMiddleware('192.168.1.52:8000');
  // await remoteDevtools.connect();
  // var prefs = await SharedPreferences.getInstance();
  final Store<AppState> store =
      Store(appReducer, initialState: AppState.initial(), middleware: []);
  // remoteDevtools.store = store;
  return store;
}
