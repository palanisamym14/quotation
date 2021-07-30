import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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

  Future<void> isUserLoggedIn() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    print(user);
    print("user");
    // user = _auth.currentUser;
    if (user != null) {
      Modular.to.navigate('dashboard/home');
    }
  }

  @override
  void initState() {
    super.initState();
    // fetchGraphql();
    isUserLoggedIn();
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
