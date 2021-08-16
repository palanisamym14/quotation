import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quotation/src/screens/dataGrid/data_grid.dart';
import 'package:quotation/src/store/state/app_state.dart';
import 'package:quotation/src/store/model/datagrid_view_model.dart';
import 'package:flutter_redux/flutter_redux.dart';

class QuotationScreen extends StatelessWidget {
  const QuotationScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, DataGridViewModel>(
      onInit: (store) {},
      converter: (store) => DataGridViewModel.fromStore(store),
      builder: (_, viewModel) => DataGrid(gridStore: viewModel),
    );
  }
}
