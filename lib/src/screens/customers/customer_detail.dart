import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quotation/src/components/add_item.dart';
import 'package:quotation/src/components/drawer.dart';
import 'package:quotation/src/screens/customers/customer.dart';
import 'package:quotation/src/screens/dataGrid/grid_constant.draft.dart';
import 'package:quotation/src/screens/quotation_history/history.dart';

class CustomerDetailContainer extends StatelessWidget {
  final Map<String, dynamic> customer;
  const CustomerDetailContainer({Key? key, required this.customer})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Detail"),
      ),
      body: Container(
        child: QuotationHistory(customerId:customer["id"] ),
      ),
    );
  }

}
