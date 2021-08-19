import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:quotation/src/components/drawer.dart';
import 'package:quotation/src/screens/quotation/quotation_screen.dart';
import 'package:quotation/src/screens/quotation_history/history.dart';
import 'package:quotation/src/store/model/navigation__view_model.dart';
import 'package:quotation/src/store/state/app_state.dart';

class QuotationHistoryScreen extends StatelessWidget {
  const QuotationHistoryScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, NavigationViewModel>(
      onInit: (store) {},
      converter: (store) => NavigationViewModel.fromStore(store),
      builder: (_, appState) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Quotation History"),
          // leading: new IconButton(
          //   icon: new Icon(Icons.more_vert),
          //   onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          // ),
        ),
        drawer: CustomDrawer(),
        body: QuotationHistory(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          child: Icon(Icons.add),
          onPressed: () {
            onAddButtonPressed(context, appState);
          },
        ),
      ),
    );
  }

  onAddButtonPressed(context, NavigationViewModel appState) async {
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(
        builder: (context) => new Scaffold(
          appBar: new AppBar(
            title: const Text('New entry'),
          ),
          body: QuotationScreen(),
        ),
      ),
    );
  }
}
