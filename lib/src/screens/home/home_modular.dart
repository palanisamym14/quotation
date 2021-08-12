import 'package:flutter_modular/flutter_modular.dart';
import 'package:quotation/src/screens/analysis/analysis_screen.dart';
import 'package:quotation/src/screens/company_details/company_details.dart';
import 'package:quotation/src/screens/favourite/favourite_screen.dart';
import 'package:quotation/src/screens/quotation/quotation_screen.dart';
import 'package:quotation/src/screens/quotation_history/quotation_history_screen.dart';
import 'package:quotation/src/screens/shedule/shedule_screen.dart';
import 'home_screen.dart';

class HomeModule extends Module {
  @override
  @override
  List<Bind> get binds => [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (context, args) => HomeScreen(), children: [
      ChildRoute('/quotation', child: (_, args) => QuotationScreen()),
      ChildRoute('/history', child: (_, args) => QuotationHistoryScreen()),
      ChildRoute('/schedule', child: (_, args) => ScheduleScreen()),
      ChildRoute('/favourite', child: (_, args) => FavouriteScreen()),
      ChildRoute('/company-details', child: (_, args) => CompanyDetailsScreen()),
    ])
  ];
}
