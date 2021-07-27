import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyScaffold extends StatelessWidget {
  final Widget? body;
  MyScaffold({this.body});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Navigator.canPop(context) ? null : Drawer(
          child: const Text('In the Drawer', textAlign: TextAlign.center),
        ),
        body: this.body
    );
  }
}