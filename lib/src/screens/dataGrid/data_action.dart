import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quotation/src/components/pdf_invoice_template.dart';
import 'package:quotation/src/screens/company_details/company_constant.dart';

class DataGridAction extends StatefulWidget {
  final List<Map<String, dynamic>> columns;
  final List<Map<String, dynamic>> data;
  const DataGridAction({Key? key, required this.data, required this.columns})
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
                onPressed: onPressed,
                icon: const Icon(Icons.save),
                label: Text("Save")),
            TextButton.icon(
                onPressed: onPressed,
                icon: const Icon(Icons.print),
                label: Text("Print"))
          ],
        ),
      ),
    );
  }

  onPressed() async {
    print(widget.columns);
    await new InvoicePdf().generatePDF(
        widget.columns
            .where((element) => element["canPrint"] ?? false)
            .toList(),
        widget.data);
  }
}
