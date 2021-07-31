///Dart import
import 'dart:io';

///Package imports
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:open_file/open_file.dart';
///To save the pdf file in the device
class FileSaveHelper {
  static const MethodChannel _platformCall = MethodChannel('launchFile');

  ///To save the pdf file in the device
  static Future<void> saveAndLaunchFile(
      List<int> bytes, String fileName) async {
    String? path;
    if (Platform.isAndroid ||
        Platform.isIOS ||
        Platform.isLinux ||
        Platform.isWindows) {
      final Directory directory = await getApplicationSupportDirectory();
      path = directory.path;
    } else {
      path = await PathProviderPlatform.instance.getApplicationSupportPath();
    }
    String _fileName = '${DateTime.now().millisecondsSinceEpoch.toString()}_$fileName';
    final File file = File(Platform.isWindows ? '$path\\$_fileName' : '$path/$_fileName');
    file.writeAsBytesSync(bytes);
    if (Platform.isAndroid || Platform.isIOS) {
      // final Map<String, String> argument = <String, String>{
      //   'file_path': '$path/$_fileName'
      // };
      try {
        //ignore: unused_local_variable
        // Map<String, String>? result = await _platformCall.invokeMethod('viewPdf', argument);
        await OpenFile.open(file.path);
      } catch (e) {
        throw Exception(e);
      }
    } else if (Platform.isWindows) {
      await Process.run('start', <String>['$path\\$_fileName'],
          runInShell: true);
    } else if (Platform.isMacOS) {
      await Process.run('open', <String>['$path/$fileName'], runInShell: true);
    } else if (Platform.isLinux) {
      await Process.run('xdg-open', <String>['$path/$fileName'],
          runInShell: true);
    }
  }
}