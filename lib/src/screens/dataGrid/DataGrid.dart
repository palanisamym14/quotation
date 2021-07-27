import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quotation/src/components/add_item.dart';

class DataGrid extends StatefulWidget {
  const DataGrid({Key? key}) : super(key: key);

  @override
  _DataGridState createState() => _DataGridState();
}

class _DataGridState extends State<DataGrid> {
  List<Map<String, dynamic>> rowData = [];
  List<Map<String, dynamic>> columns = [
    {
      "label": "S NO",
      "_key": "sno",
      "width": "30",
      "isVisible": true,
      "labelAlign": "center",
      "textAlign": Alignment.center,
      "allowAddScreen": false,
      "keyboardType": TextInputType.text,
    },
    {
      "label": "Description",
      "_key": "description",
      "width": "30",
      "isVisible": true,
      "labelAlign": "center",
      "textAlign": Alignment.centerLeft,
      "allowAddScreen": true,
      "keyboardType": TextInputType.text,
    },
    {
      "label": "Quantity",
      "_key": "quantity",
      "width": "30",
      "isVisible": true,
      "labelAlign": "center",
      "textAlign": Alignment.centerLeft,
      "allowAddScreen": true,
      "keyboardType": TextInputType.number,
    },
    {
      "label": "Unit price ",
      "_key": "price",
      "width": "30",
      "isVisible": true,
      "labelAlign": "center",
      "textAlign": Alignment.centerRight,
      "allowAddScreen": true,
      "keyboardType": TextInputType.number,
    },
    {
      "label": "Total price",
      "_key": "totalPrice",
      "width": "30",
      "isVisible": true,
      "labelAlign": "center",
      "textAlign": Alignment.centerRight,
      "allowAddScreen": true,
      "keyboardType": TextInputType.number,
    },
    {
      "type": "action",
      "isVisible": true,
      "label": "Action",
      "width": "30",
      "labelAlign": "center",
      "textAlign": Alignment.centerRight,
      "allowAddScreen": false,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: List.generate(columns.length, (index) {
              return DataColumn(
                label: Expanded(
                    child: Text(
                  columns[index]["label"],
                  style: TextStyle(fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                )),
              );
            }),
            rows: List.generate(rowData.length, (idx) {
              return DataRow(
                  cells: List.generate(columns.length, (index) {
                var _key = columns[index]["_key"];
                return DataCell(columns[index]["type"] == "action"
                    ? Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {},
                          ),
                        ],
                      )
                    : Align(
                        alignment: columns[index]["textAlign"],
                        child: Text(
                          rowData[idx][_key] == null ? '' : rowData[idx][_key],
                        )));
              }));
            }),
            headingRowHeight: 50.0,
            dataRowHeight: 40.0,
          ),
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                _navigateAndDisplaySelection(context);
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Grand Total'),
            new InkWell(
              onTap: () {},
              child: new Padding(
                padding: new EdgeInsets.all(10.0),
                child: new Text("Tap Here"),
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Adjustment'),
            new InkWell(
              onTap: () {},
              child: new Padding(
                padding: new EdgeInsets.all(10.0),
                child: new Text("Tap Here"),
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Net Amount'),
            new InkWell(
              onTap: () {},
              child: new Padding(
                padding: new EdgeInsets.all(10.0),
                child: new Text("Tap Here"),
              ),
            )
          ],
        ),
      ],
    );
  }

  void _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(
          builder: (context) => AddItemForm(
              columns: columns
                  .where((element) => element["allowAddScreen"])
                  .toList())),
    );
    print("result");
    print(result);
    setState(() {
      rowData.add(result);
    });
  }
}
