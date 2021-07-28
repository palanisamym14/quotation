import 'package:flutter/material.dart';

asyncInputDialog(BuildContext context, String text) async {
  String teamName = text;
  return showDialog(
    context: context,
    barrierDismissible: false,
    // dialog is dismissible with a tap on the barrier
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Enter current team'),
        content: new Row(
          children: [
            new Expanded(
                child: new TextFormField(
              initialValue: text,
              autofocus: true,
              decoration: new InputDecoration(
                  labelText: 'Team Name', hintText: 'eg. 1000.00.'),
              onChanged: (value) {
                teamName = value;
              },
            ))
          ],
        ),
        actions: [
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop(teamName);
            },
          ),
        ],
      );
    },
  );
}
