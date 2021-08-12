import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quotation/src/screens/quotation/quotation_screen.dart';
import 'package:quotation/src/screens/quotation_history/history.dart';

class QuotationHistoryScreen extends StatelessWidget {
  const QuotationHistoryScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QuotationHistory(),
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
          appBar: new AppBar(
            title: const Text('New entry'),
          ),
          body: QuotationScreen(),
        ),
      ),
    );
  }
}
