import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:quotation/app_module.dart';
import 'package:quotation/app_widget.dart';
import 'dart:async';

import 'package:quotation/setup.dart';
import 'package:quotation/src/store/app_store.dart';

Future<void> main() async {
  await Setup.init();
  var store = await createStore();
  runApp(ModularApp(module: AppModule(), child: AppWidget(store)));
}
