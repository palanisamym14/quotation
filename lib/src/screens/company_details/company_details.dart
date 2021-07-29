import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quotation/src/components/add_item.dart';
import 'package:quotation/src/screens/company_details/company_constant.dart';

class CompanyDetailsScreen extends StatefulWidget {
  const CompanyDetailsScreen({Key? key}) : super(key: key);

  @override
  _CompanyDetailsScreenState createState() => _CompanyDetailsScreenState();
}

class _CompanyDetailsScreenState extends State<CompanyDetailsScreen> {
  Map<String, String> stringParams = {
    "description": '',
  };
  @override
  Widget build(BuildContext context) {
    print(formColumns);
    return AddItemForm(
      columns: formColumns,
      initValues: stringParams,
      header: "Company Details",
    );
  }
}
