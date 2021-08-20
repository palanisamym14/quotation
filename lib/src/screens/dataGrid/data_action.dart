import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quotation/src/components/pdf_invoice_template.dart';
import 'package:quotation/src/repo/data_grid_repo.dart';
import 'package:quotation/src/modal/data_print.dart';
import 'package:quotation/src/screens/dataGrid/grid_constant.draft.dart';
import 'package:quotation/src/store/model/datagrid_view_model.dart';
import 'package:quotation/src/utils/util.dart';

class DataGridAction extends StatefulWidget {
  final DataGridViewModel gridStore;

  const DataGridAction({Key? key, required this.gridStore}) : super(key: key);

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
                onPressed: () => onPressed(context),
                icon: const Icon(Icons.save),
                label: Text("Save")),
            TextButton.icon(
                onPressed: () => onPressed(context),
                icon: const Icon(Icons.print),
                label: Text("Print"))
          ],
        ),
      ),
    );
  }

  onPressed(BuildContext context) async {
    // final path = await DBQuotation().getDatabasePath();
    await new DataGridRepo().saveDataGrid(widget.gridStore.rowData,
        widget.gridStore.customerDetail, widget.gridStore.summaryData);
    PrintResponseModal printResponseModal = new PrintResponseModal();
    printResponseModal.columns = quotationItemColumns
        .where((element) => element["canPrint"] ?? false)
        .toList();
    printResponseModal.data = widget.gridStore.rowData;
    List<String> to = [];
    customerDetailColumns.forEach((ele) {
      var val = widget.gridStore.customerDetail[ele['_key']];
      if (val != null && val != '') {
        to.add(val);
      }
    });
    printResponseModal.header.to = to;
    List<Map<String, dynamic>> _footer = [];
    summaryColumns.forEach((ele) {
      var val = widget.gridStore.summaryData[ele['_key']];
      if (val != null && val != '') {
        _footer.add({
          "key": ele['_key'],
          "label": ele['label'],
          "value": currency(context, val).value
        });
      }
    });

    printResponseModal.footer = _footer;
    print(printResponseModal.footer);
    await new InvoicePdf().generatePDF(printResponseModal);
  }
}
