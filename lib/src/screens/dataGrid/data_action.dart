import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quotation/src/components/pdf_invoice_template.dart';
import 'package:quotation/src/modal/data_grid_repo.dart';
import 'package:quotation/src/modal/data_print.dart';
import 'package:quotation/src/screens/dataGrid/grid_constant.draft.dart';
import 'package:quotation/src/utils/util.dart';

class DataGridAction extends StatefulWidget {
  final List<Map<String, dynamic>> columns;
  final List<Map<String, dynamic>> data;
  final Map<String, dynamic> header;
  final Map<String, dynamic> footer;

  const DataGridAction(
      {Key? key,
      required this.data,
      required this.columns,
      required this.header,
      required this.footer})
      : super(key: key);

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
    await new DataGridRepo().saveDataGrid(widget.data, widget.header, widget.footer);
    PrintResponseModal printResponseModal = new PrintResponseModal();
    printResponseModal.columns = widget.columns
        .where((element) => element["canPrint"] ?? false)
        .toList();
    printResponseModal.data = widget.data;
    List<String> to = [];
    headerColumns.forEach((ele) {
      var val = widget.header[ele['_key']];
      if (val != null && val != '') {
        to.add(val);
      }
    });
    printResponseModal.header.to = to;
    List<Map<String, dynamic>> _footer = [];
    footerColumns.forEach((ele) {
      var val = widget.footer[ele['_key']];
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
