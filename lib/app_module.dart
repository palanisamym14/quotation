import 'package:flutter_modular/flutter_modular.dart';
import 'package:quotation/src/screens/Login/login_screen.dart';
import 'package:quotation/src/screens/Signup/signup_screen.dart';
// import 'package:quotation/src/screens/call_sample/call_sample.dart';
import 'package:quotation/src/screens/home/home_modular.dart';
import 'package:quotation/src/screens/welcome/welcome_screen.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: HomeModule()),
    ChildRoute('/welcome', child: (_, __) => WelcomeScreen()),
    ChildRoute('/login', child: (_, __) => LoginScreen()),
    ChildRoute('/signup', child: (_, __) => SignUpScreen()),
    // ChildRoute('/details', child: (_, args) => CallSample({host:''})),
  ];
}