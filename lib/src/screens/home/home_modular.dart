import 'package:flutter_modular/flutter_modular.dart';
import 'package:quotation/src/screens/company_details/company_details.dart';
import 'package:quotation/src/screens/customers/customer_container.dart';
import 'package:quotation/src/screens/product/product_container.dart';
import 'package:quotation/src/screens/quotation_history/quotation_history_screen.dart';
import 'home_screen.dart';

class HomeModule extends Module {
  @override
  @override
  List<Bind> get binds => [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (context, args) => HomeScreen(), children: [
      ChildRoute('/history', child: (_, args) => QuotationHistoryScreen()),
      ChildRoute('/product', child: (_, args) => ProductListContainer()),
      ChildRoute('/customer', child: (_, args) => CustomerContainer()),
      ChildRoute('/company-details', child: (_, args) => CompanyDetailsScreen()),
    ])
  ];
}
