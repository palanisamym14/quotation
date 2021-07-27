import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotation/src/modal/logging.dart';
import 'package:quotation/src/utils/graphql_client.dart';

class AppWidget extends StatefulWidget {
  _AppWidgetState createState() => new _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  fetchGraphql() async {
    await initConnection();
  }

  @override
  initState() {
    super.initState();
    fetchGraphql();
    AppLog("ALL");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.green,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.green, //Colors.green,
          ).copyWith(
            secondary: Colors.green[400],
          ),
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme,
          )),
    ).modular();
  }
}
