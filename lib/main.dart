import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:quotation/app_module.dart';
import 'package:quotation/app_widget.dart';
import 'dart:async';

import 'package:quotation/setup.dart';

Future<void> main() async {
  await Setup.init();
  runApp(ModularApp(module: AppModule(), child: AppWidget()));
}
