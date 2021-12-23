import 'package:flutter_modular/flutter_modular.dart';
import 'package:quotation/module_guard.dart';
import 'package:quotation/src/screens/home/home_modular.dart';
import 'package:quotation/src/screens/welcome/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        AsyncBind((i) => SharedPreferences.getInstance()),
      ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: HomeModule()),
    ChildRoute('/login', child: (_, __) => WelcomeScreen()),
    // ChildRoute('/details', child: (_, args) => CallSample({host:''})),
  ];
}
