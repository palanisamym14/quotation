import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quotation/src/utils/db.dart';

class Setup {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await Db.create().connect();
    // await createHintFile();
  }

  static Future<void> createHintFile() async {
    // if (Platform.isAndroid) {
    //   final List<Directory>? directories =
    //       await getExternalStorageDirectories();
    //   final File hintFile =
    //       File('${directories![0]?.path}/put_your_fit_files_here.txt');
    //   await hintFile.writeAsString(
    //       'This is the directory where Quotation can pickup .fit-files from.');
    // } else {
    //   final Directory directory = await getApplicationDocumentsDirectory();
    //   final File hintFile =
    //       File('${directory.path}/put_your_fit_files_here.txt');
    //   await hintFile.writeAsString(
    //       'This is the directory where Quotation can pickup .fit-files from.');
    // }
  }
}
