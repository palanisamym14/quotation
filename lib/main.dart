import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:quotation/app_module.dart';
import 'package:quotation/app_widget.dart';

void main() =>  runApp(ModularApp(module: AppModule(), child: AppWidget()));
  