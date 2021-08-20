import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quotation/src/screens/dataGrid/data_grid.dart';
import 'package:quotation/src/store/state/app_state.dart';
import 'package:quotation/src/store/model/datagrid_view_model.dart';
import 'package:flutter_redux/flutter_redux.dart';

class QuotationScreen extends StatefulWidget {
  final String? quotationId;
  const QuotationScreen({Key? key, this.quotationId}) : super(key: key);

  @override
  _QuotationScreenState createState() => _QuotationScreenState();
}

class _QuotationScreenState extends State<QuotationScreen> {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, DataGridViewModel>(
      onInit: (store) {},
      converter: (store) => DataGridViewModel.fromStore(store),
      builder: (_, viewModel) =>
          DataGrid(gridStore: viewModel, quotationId: widget.quotationId),
    );
  }
}
