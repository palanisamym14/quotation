import 'package:flutter/material.dart';
// {
// "type": "image",
// "label": "Company Logo",
// "_key": "logo",
// "width": "30",
// "isVisible": true,
// "labelAlign": "center",
// "textAlign": Alignment.centerLeft,
// "allowAddScreen": true,
// "keyboardType": TextInputType.text,
// "isRequired": true,
// }
const List<Map<String, dynamic>> formColumns = [
  {
    "type": "list",
    "label": "Company Name",
    "_key": "name",
    "width": "30",
    "isVisible": true,
    "labelAlign": "center",
    "textAlign": Alignment.centerLeft,
    "allowAddScreen": true,
    "keyboardType": TextInputType.text,
    "isRequired": true,
    "query": 'SELECT name, id FROM company where name like "%:input%" LIMIT 100',
  },
  {
    "type": "text",
    "label": "Address Line 1",
    "_key": "addressLine1",
    "width": "30",
    "isVisible": true,
    "labelAlign": "center",
    "textAlign": Alignment.centerLeft,
    "allowAddScreen": true,
    "keyboardType": TextInputType.streetAddress,
    "isRequired": false
  },
  {
    "type": "text",
    "label": "Address Line 2",
    "_key": "addressLine2",
    "width": "30",
    "isVisible": true,
    "labelAlign": "center",
    "textAlign": Alignment.centerLeft,
    "allowAddScreen": true,
    "keyboardType": TextInputType.streetAddress,
    "isRequired": false
  },
  {
    "type": "text",
    "label": "SSN/GST No",
    "_key": "ssn",
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
    "label": "Contact No",
    "_key": "mobile",
    "width": "30",
    "isVisible": true,
    "labelAlign": "center",
    "textAlign": Alignment.centerLeft,
    "allowAddScreen": true,
    "keyboardType": TextInputType.phone,
    "isRequired": false
  },{
    "type": "text",
    "label": "Email Address",
    "_key": "email",
    "width": "30",
    "isVisible": true,
    "labelAlign": "center",
    "textAlign": Alignment.centerLeft,
    "allowAddScreen": true,
    "keyboardType": TextInputType.emailAddress,
    "isRequired": false
  }
];
