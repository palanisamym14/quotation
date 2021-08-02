import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quotation/src/components/add_item.dart';
import 'package:quotation/src/screens/dataGrid/grid_constant.draft.dart';

typedef void SignalingStateCallback(dynamic data);

class DataGridHeader extends StatefulWidget {
  final Map<String, dynamic> companyDetail;
  final SignalingStateCallback onHeaderDataChange;

  const DataGridHeader(
      {Key? key, required this.companyDetail, required this.onHeaderDataChange})
      : super(key: key);
  @override
  _DataGridHeaderState createState() => _DataGridHeaderState();
}

class _DataGridHeaderState extends State<DataGridHeader> {
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
                'Customer Details ',
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
          new ListView.builder(
              shrinkWrap: true,
              itemCount: headerColumns.length,
              itemBuilder: (context, index) {
                var val = widget.companyDetail[headerColumns[index]["_key"]];
                return val == null
                    ? Container(
                        height: 0,
                        width: 0,
                      )
                    : Text(val);
              })
        ],
      ),
    ));
  }

  void _navigateAndDisplaySelection(BuildContext context) async {
    Map<String, dynamic> val = widget.companyDetail;
    // print("_val");
    print(val);
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(
        builder: (context) => AddItemForm(
            columns: headerColumns
                .where((element) => element["allowAddScreen"])
                .toList(),
            initValues: val,
            header: "Add Address"),
      ),
    );
    setState(() {
      widget.onHeaderDataChange(result);
    });
  }
}
