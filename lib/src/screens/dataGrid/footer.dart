import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quotation/src/components/custom_text_form.dart';
import 'package:quotation/src/screens/dataGrid/grid_constant.draft.dart';
import 'package:quotation/src/store/model/datagrid_view_model.dart';
import 'package:collection/collection.dart';

typedef void SignalingStateCallback(dynamic data);
Function eq = const DeepCollectionEquality().equals;
const footerDefault = {"grandTotal": 0.00, "discount": 0.00, "netPay": 0.00};

class DataGridFooter extends StatefulWidget {
  final DataGridViewModel gridStore;

  const DataGridFooter({Key? key, required this.gridStore}) : super(key: key);
  @override
  _DataGridFooterState createState() => _DataGridFooterState();
}

class _DataGridFooterState extends State<DataGridFooter> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(DataGridFooter oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: List.generate(
            summaryColumns.length,
            (index) {
              var item = summaryColumns[index];
              var obj = widget.gridStore.summaryData;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item['label']),
                  Expanded(
                    child: new CustomEditForm(
                        value: obj[item['_key']] ?? 0,
                        keyName: item['_key'],
                        callback: onFooterValueChanged),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  onFooterValueChanged(val, key) {
    var tempVal = val ?? 0;
    tempVal = double.parse(val);
    Map<String, dynamic> _footerValue =
        new Map<String, dynamic>.of(widget.gridStore.summaryData);
    _footerValue[key] = tempVal;
    if (key == "grandTotal") {
      _footerValue["netPay"] = tempVal - (_footerValue["discount"] ?? 0);
    } else if (key == "discount") {
      _footerValue["netPay"] = (_footerValue["grandTotal"] ?? 0) - tempVal;
    }
    widget.gridStore.updateSummary(_footerValue);
  }
}
