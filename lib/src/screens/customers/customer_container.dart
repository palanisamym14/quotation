import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quotation/src/components/add_item.dart';
import 'package:quotation/src/components/drawer.dart';
import 'package:quotation/src/screens/customers/customer.dart';
import 'package:quotation/src/screens/dataGrid/grid_constant.draft.dart';
import 'package:quotation/src/screens/quotation/quotation_screen.dart';

class CustomerContainer extends StatelessWidget {
  const CustomerContainer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Customer List"),
      ),
      drawer: CustomDrawer(),
      body: CustomerList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
        onPressed: () {
          onAddButtonPressed(context);
        },
      ),
    );
  }

  onAddButtonPressed(context) async {
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(
        builder: (context) => new Scaffold(
          body: AddItemForm(
              columns: customerDetailColumns
                  .where((element) => element["allowAddScreen"])
                  .toList(),
              initValues: {},
              header: "Add Customer Details"),
        ),
      ),
    );
  }
}
