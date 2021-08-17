import 'package:flutter/material.dart';

import 'async_input_popup.dart';

typedef void StringCallback(String val, String key);

class CustomEditForm extends StatefulWidget {
  final String keyName;
  final dynamic value;
  final StringCallback callback;

  CustomEditForm({this.value, required this.keyName, required this.callback});

  @override
  _CustomEditFormState createState() => _CustomEditFormState();
}

class _CustomEditFormState extends State<CustomEditForm> {
  var editable = false;
  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onDoubleTap: () async {
        var result = await asyncInputDialog(context,
            double.parse((widget.value)?.toStringAsFixed(2)).toString());
        setState(() {
          editable = !editable;
          widget.callback(result, widget.keyName);
        });
      },
      child: Text(double.parse((widget.value)?.toStringAsFixed(2)).toString(),
          textAlign: TextAlign.right),
    );
  }
}
