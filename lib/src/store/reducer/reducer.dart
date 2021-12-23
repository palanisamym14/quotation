import 'package:quotation/src/store/state/app_state.dart';
import 'package:quotation/src/store/reducer/signin_reducer.dart';
import 'datagrid_reducer.dart';

AppState appReducer(AppState state, dynamic action) => new AppState(
    dataGridState: dataGridReducer(state.dataGridState, action),
    menuState: menuReducer(state.menuState, action));
