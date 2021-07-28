import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quotation/src/components/add_item.dart';

class DataGridHeader extends StatefulWidget {
  const DataGridHeader({Key? key}) : super(key: key);

  @override
  _DataGridHeaderState createState() => _DataGridHeaderState();
}

class _DataGridHeaderState extends State<DataGridHeader> {
  List<Map<String, dynamic>> columns = [
    {
      "type": "text",
      "label": "Company Name",
      "_key": "companyName",
      "width": "30",
      "isVisible": true,
      "labelAlign": "center",
      "textAlign": Alignment.centerLeft,
      "allowAddScreen": true,
      "keyboardType": TextInputType.text,
      "isRequired": true,
    },
    {
      "type": "text",
      "label": "Address Line1",
      "_key": "addressLine1",
      "width": "30",
      "isVisible": true,
      "labelAlign": "center",
      "textAlign": Alignment.centerLeft,
      "allowAddScreen": true,
      "keyboardType": TextInputType.text,
      "isRequired": false
    },
    {
      "type": "text",
      "label": "Address Line2",
      "_key": "addressLine2",
      "width": "30",
      "isVisible": true,
      "labelAlign": "center",
      "textAlign": Alignment.centerLeft,
      "allowAddScreen": true,
      "keyboardType": TextInputType.text,
      "isRequired": false
    },
    {
      "type": "text",
      "label": "Mobile",
      "_key": "mobile",
      "width": "30",
      "isVisible": true,
      "labelAlign": "center",
      "textAlign": Alignment.centerLeft,
      "allowAddScreen": true,
      "keyboardType": TextInputType.text,
      "isRequired": false
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'To Address1 ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.green[300],
                  ),
                  onPressed: () {
                    _navigateAndDisplaySelection(context);
                    setState(() {});
                  })
            ],
          ),
          Text("CompanyName"),
          Text("Address"),
          Text("Phone"),
        ],
      ),
    ));
  }

  void _navigateAndDisplaySelection(BuildContext context) async {
    Map<String, dynamic> val = {};
    // print("_val");
    print(val);
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(
        builder: (context) => AddItemForm(
          columns:
              columns.where((element) => element["allowAddScreen"]).toList(),
          initValues: val,
          header:"Add Address"
        ),
      ),
    );
    print(result);
  }
}
