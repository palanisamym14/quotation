import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotation/src/modal/logging.dart';
import 'package:quotation/src/store/state/app_state.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

class AppWidget extends StatefulWidget {
  final Store<AppState> store;
  AppWidget(this.store);
  _AppWidgetState createState() => new _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  fetchGraphql() async {}

  Future<void> isUserLoggedIn() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    if (user != null) {
      Modular.to.navigate('dashboard/home');
    }
  }

  @override
  void initState() {
    super.initState();
    isUserLoggedIn();
    AppLog("ALL");
  }

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
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
          ),
        ),
      ).modular(),
    );
  }
}
