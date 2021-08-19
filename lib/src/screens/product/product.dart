import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:quotation/src/repo/data_grid_repo.dart';
import 'package:intl/intl.dart';
import 'package:quotation/src/utils/util.dart';
import 'package:flutter_svg/flutter_svg.dart';

final f = new DateFormat('yyyy-MM-dd');
final quotationFormat = new DateFormat('d-H-m-s');

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List quotationHistory = [];
  loadInitData() {
    DataGridRepo().getQuotationHistory().then((_quotationHistory) {
      print(_quotationHistory);
      setState(() {
        quotationHistory = _quotationHistory;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // fetchGraphql();
    print("Data");
    loadInitData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: quotationHistory.length == 0
            ? new Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        new Container(
                          width: 300.0,
                          height: 300.0,
                          decoration: new BoxDecoration(
                            color: Colors.green[50],
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            "assets/images/notification.svg",
                            width: 100,
                            height: 144,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : new Container(),
      ),
    );
  }
}
