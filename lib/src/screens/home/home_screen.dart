import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:quotation/src/components/bottom_nav_bar.dart';
import 'package:quotation/src/store/model/app_view_model.dart';
import 'package:quotation/src/store/state/app_state.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, AppViewModel>(
      onInit: (store) {},
      converter: (store) => AppViewModel.fromStore(store),
      builder: (_, appState) => BottomNavBar(
        appState: appState,
        body: RouterOutlet(),
      ),
    );
  }
}
