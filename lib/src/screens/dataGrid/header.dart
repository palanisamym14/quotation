import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quotation/src/components/add_item.dart';
import 'package:quotation/src/screens/dataGrid/grid_constant.draft.dart';
import 'package:quotation/src/store/model/datagrid_view_model.dart';
// import 'package:quotation/src/utils/util.dart';

typedef void SignalingStateCallback(dynamic data);

class DataGridHeader extends StatefulWidget {
  final DataGridViewModel gridStore;

  const DataGridHeader({Key? key, required this.gridStore}) : super(key: key);
  @override
  _DataGridHeaderState createState() => _DataGridHeaderState();
}

class _DataGridHeaderState extends State<DataGridHeader> {
  List<String> addressDetails = [];
  @override
  void initState() {
    print("widget.companyDetail");
    print(widget.gridStore.customerDetail);
    headerValuesChange(widget.gridStore.customerDetail);
    super.initState();
  }

  @override
  void didUpdateWidget(DataGridHeader oldWidget) {
    super.didUpdateWidget(oldWidget);
    headerValuesChange(widget.gridStore.customerDetail);
  }

  @override
  void setState(fn) {
    super.setState(fn);
  }

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
              itemCount: addressDetails.length,
              itemBuilder: (context, index) {
                var val = addressDetails[index];
                return Text(val);
              })
        ],
      ),
    ));
  }

  void _navigateAndDisplaySelection(BuildContext context) async {
    Map<String, dynamic> val = widget.gridStore.customerDetail;
    // print("_val");
    print(val);
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(
        builder: (context) => AddItemForm(
            columns: customerDetailColumns
                .where((element) => element["allowAddScreen"])
                .toList(),
            initValues: val,
            header: "Add Customer Details"),
      ),
    );
    widget.gridStore.updateCustomer!(result);
  }

  headerValuesChange(Map<String, dynamic> companyDetail) {
    List<String> to = [];
    print(companyDetail);
    customerDetailColumns.forEach((ele) {
      var val = companyDetail[ele['_key']];
      if (val != null && val != '') {
        to.add(val.toString());
      }
    });
    setState(() {
      this.addressDetails = to;
    });
  }
}
