import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quotation/src/screens/dataGrid/data_grid.dart';

class QuotationScreen extends StatelessWidget {
  const QuotationScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DataGrid();
  }
}
