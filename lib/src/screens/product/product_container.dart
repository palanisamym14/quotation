import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quotation/src/components/add_item.dart';
import 'package:quotation/src/components/drawer.dart';
import 'package:quotation/src/screens/dataGrid/grid_constant.draft.dart';
import 'package:quotation/src/screens/product/product.dart';
import 'package:quotation/src/screens/quotation/quotation_screen.dart';

class ProductListContainer extends StatelessWidget {
  const ProductListContainer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Product List"),
      ),
      drawer: CustomDrawer(),
      body: ProductList(),
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
              columns: quotationItemColumns
                  .where((element) => element["allowAddScreen"])
                  .toList(),
              initValues: {},
              header: "Add Item Details"),
        ),
      ),
    );
  }
}
