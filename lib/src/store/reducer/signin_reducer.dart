import 'package:quotation/src/store/actions/menu_action.dart';
import 'package:quotation/src/store/state/menu_state.dart';
import 'package:redux/redux.dart';

final menuReducer = combineReducers<MenuState>([
  TypedReducer<MenuState, ShowAppBarAction>(showAppBar),
  TypedReducer<MenuState, HideAppBarAction>(hideAppBar),
]);

MenuState showAppBar(MenuState state, ShowAppBarAction action) {
  return state.copyWith(isVisible: true);
}

MenuState hideAppBar(MenuState state, HideAppBarAction action) {
  return state.copyWith(isVisible: false);
}
