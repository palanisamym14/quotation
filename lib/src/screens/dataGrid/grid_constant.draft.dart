import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

final List<Map<String, dynamic>> gridColumns = [
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
    "canPrint": true,
    "pdfTextAlignment": PdfTextAlignment.left
  },
  {
    "type": "list",
    "label": "Description",
    "_key": "description",
    "width": "30",
    "isVisible": true,
    "labelAlign": "center",
    "textAlign": Alignment.centerLeft,
    "allowAddScreen": true,
    "keyboardType": TextInputType.text,
    "isRequired": true,
    "canPrint": true,
    "pdfTextAlignment": PdfTextAlignment.left,
    "query": 'SELECT description as name, id FROM product where name like "%:input%" LIMIT 100',
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
    "canPrint": true,
    "pdfTextAlignment": PdfTextAlignment.left
  },
  {
    "type": "currency",
    "label": "Unit price ",
    "_key": "price",
    "width": "30",
    "isVisible": true,
    "labelAlign": "center",
    "textAlign": Alignment.centerRight,
    "allowAddScreen": true,
    "keyboardType": TextInputType.number,
    "isRequired": true,
    "canPrint": true,
    "pdfTextAlignment": PdfTextAlignment.right
  },
  {
    "type": "currency",
    "label": "Total price",
    "_key": "totalPrice",
    "width": "30",
    "isVisible": true,
    "labelAlign": "center",
    "textAlign": Alignment.centerRight,
    "allowAddScreen": true,
    "keyboardType": TextInputType.number,
    "isRequired": true,
    "canPrint": true,
    "pdfTextAlignment": PdfTextAlignment.right
  },
  {
    "type": "action",
    "isVisible": true,
    "label": "Action",
    "width": "30",
    "labelAlign": "center",
    "textAlign": Alignment.centerRight,
    "allowAddScreen": false,
    "canPrint": false,
  }
];

final List<Map<String, dynamic>> headerColumns = [
  {
    "type": "list",
    "label": "Customer Name",
    "_key": "name",
    "width": "30",
    "isVisible": true,
    "labelAlign": "center",
    "textAlign": Alignment.centerLeft,
    "allowAddScreen": true,
    "keyboardType": TextInputType.text,
    "isRequired": true,
    "query": 'SELECT name, id FROM customer where name like "%:input%" LIMIT 100',
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

final List<Map<String, dynamic>> summaryColumns = [
  {
    "type": "text",
    "label": "Grand Total",
    "_key": "grandTotal",
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
    "label": "discount",
    "_key": "discount",
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
    "label": "Net Pay",
    "_key": "netPay",
    "width": "30",
    "isVisible": true,
    "labelAlign": "center",
    "textAlign": Alignment.centerLeft,
    "allowAddScreen": true,
    "keyboardType": TextInputType.text,
    "isRequired": false
  }
];


