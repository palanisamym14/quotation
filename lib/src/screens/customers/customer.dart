import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quotation/src/repo/customer_repo.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';

final f = new DateFormat('yyyy-MM-dd');
final quotationFormat = new DateFormat('d-H-m-s');

class CustomerList extends StatefulWidget {
  const CustomerList({Key? key}) : super(key: key);
  @override
  _CustomerListState createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  List customerList = [];
  loadInitData() {
    new CustomerRepo().getCustomerHistory().then((_customerList) {
      print("_customerList");
      print(_customerList);
      setState(() {
        customerList = _customerList;
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
        body: customerList.length == 0
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
