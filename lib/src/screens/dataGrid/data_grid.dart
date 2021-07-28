import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quotation/src/components/add_item.dart';
import 'package:quotation/src/components/custom_text_form.dart';
import 'header.dart';

class DataGrid extends StatefulWidget {
  const DataGrid({Key? key}) : super(key: key);

  @override
  _DataGridState createState() => _DataGridState();
}

class _DataGridState extends State<DataGrid> {
  List<Map<String, dynamic>> rowData = [];
  List<Map<String, dynamic>> columns = [
    {
      "type": "index",
      "label": "S NO",
      "_key": "sno",
      "width": "30",
      "isVisible": true,
      "labelAlign": "center",
      "textAlign": Alignment.center,
      "allowAddScreen": false,
      "keyboardType": TextInputType.text,
      "isRequired": true,
    },
    {
      "type": "text",
      "label": "Description",
      "_key": "description",
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
      "label": "Quantity",
      "_key": "quantity",
      "width": "30",
      "isVisible": true,
      "labelAlign": "center",
      "textAlign": Alignment.centerLeft,
      "allowAddScreen": true,
      "keyboardType": TextInputType.number,
      "isRequired": true,
    },
    {
      "type": "text",
      "label": "Unit price ",
      "_key": "price",
      "width": "30",
      "isVisible": true,
      "labelAlign": "center",
      "textAlign": Alignment.centerRight,
      "allowAddScreen": true,
      "keyboardType": TextInputType.number,
      "isRequired": true,
    },
    {
      "type": "text",
      "label": "Total price",
      "_key": "totalPrice",
      "width": "30",
      "isVisible": true,
      "labelAlign": "center",
      "textAlign": Alignment.centerRight,
      "allowAddScreen": true,
      "keyboardType": TextInputType.number,
      "isRequired": true,
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

  Map<String, dynamic> footerValue = {
    "grandTotal": 0.00,
    "discount": 0.00,
    "netPay": 0.00
  };
  Map<String, String> stringParams = {
    "description": '',
  };

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        DataGridHeader(),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: MaterialStateColor.resolveWith(
                (states) => Colors.green.withOpacity(0.3)),
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
                  color: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    // Even rows will have a grey color.
                    if (idx % 2 == 0) return Colors.green.withOpacity(0.1);
                    return Colors.green.withOpacity(
                        0.2); // Use default value for other states and odd rows.
                  }),
                  cells: List.generate(columns.length, (index) {
                    return DataCell(
                        _dataCell(context, idx, columns[index], rowData[idx]));
                  }));
            }),
            headingRowHeight: 50.0,
            dataRowHeight: 40.0,
          ),
        ),
        Row(
          children: [
            new IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                _navigateAndDisplaySelection(context, stringParams, -1);
              },
            ),
          ],
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Grand Total'),
                    Expanded(
                        child: new CustomEditForm(
                            value: footerValue["grandTotal"],
                            keyName: "grandTotal",
                            callback: onFooterValueChanged)),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Adjustment'),
                    Expanded(
                        child: new CustomEditForm(
                            value: footerValue["discount"],
                            keyName: "discount",
                            callback: onFooterValueChanged)),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Net Amount'),
                    Expanded(
                        child: new CustomEditForm(
                      value: footerValue["netPay"],
                      keyName: "netPay",
                      callback: onFooterValueChanged,
                    )),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  onFooterValueChanged(val, key) {
    var tempVal = val;
    tempVal = double.parse(val);
    setState(() {
      footerValue.update(key, (value) => tempVal);
    });
    if (key == "grandTotal") {
      setState(() {
        footerValue.update(
            "netPay", (value) => tempVal - footerValue["discount"]);
      });
    } else if (key == "discount") {
      setState(() {
        footerValue.update(
            "netPay", (value) => footerValue["grandTotal"] - tempVal);
      });
    }
  }

  _dataCell(BuildContext context, rowIdx, column, item) {
    var _key = column["_key"];
    var type = column["type"];
    switch (type) {
      case "action":
        return Row(
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                _navigateAndDisplaySelection(context, item, rowIdx);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {},
            ),
          ],
        );
      case "index":
        return Align(
            alignment: column["textAlign"],
            child: Text((rowIdx + 1).toString()));
      default:
        return Align(
            alignment: column["textAlign"],
            child: Text(
              item[_key] == null ? '' : item[_key],
            ));
    }
  }

  void _navigateAndDisplaySelection(BuildContext context, val, idx) async {
    // Map<String, dynamic> _val = Map<String, dynamic>.from(val);
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
          header: "Add Item",
        ),
      ),
    );
    if (result != null) {
      setState(() {
        if (idx == -1) {
          rowData.add(result);
        } else {
          rowData[idx] = result;
        }
      });
      onFooterValueChanged(
          rowData
              .map((e) => double.parse(e["totalPrice"]))
              .reduce((a, b) => a + b)
              .toString(),
          "grandTotal");
    }
  }
}
