import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:quotation/app_module.dart';
import 'package:quotation/app_widget.dart';
import 'dart:async';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  runApp(ModularApp(module: AppModule(), child: AppWidget()));
}
