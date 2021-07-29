import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DataGridAction extends StatefulWidget {
  const DataGridAction({Key? key}) : super(key: key);

  @override
  _DataGridActionState createState() => _DataGridActionState();
}

class _DataGridActionState extends State<DataGridAction> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.save),
                label: Text("Save")),
            TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.print),
                label: Text("Print"))
          ],
        ),
      ),
    );
  }
}
