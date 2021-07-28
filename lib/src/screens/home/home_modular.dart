import 'package:flutter_modular/flutter_modular.dart';
import 'package:quotation/src/screens/analysis/analysis_screen.dart';
import 'package:quotation/src/screens/favourite/favourite_screen.dart';
import 'package:quotation/src/screens/quotation/quotation_screen.dart';
import 'package:quotation/src/screens/shedule/shedule_screen.dart';
import 'home_screen.dart';

class HomeModule extends Module {
  @override
  @override
  List<Bind> get binds => [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (context, args) => HomeScreen(), children: [
      ChildRoute('/home', child: (_, args) => QuotationScreen()),
      ChildRoute('/analysis', child: (_, args) => AnalysisScreen()),
      ChildRoute('/schedule', child: (_, args) => ScheduleScreen()),
      ChildRoute('/favourite', child: (_, args) => FavouriteScreen()),
    ])
  ];
}
