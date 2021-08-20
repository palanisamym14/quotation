import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quotation/src/repo/customer_repo.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quotation/src/screens/dataGrid/grid_constant.draft.dart';

final f = new DateFormat('yyyy-MM-dd');
final quotationFormat = new DateFormat('d-H-m-s');

class CustomerList extends StatefulWidget {
  const CustomerList({Key? key}) : super(key: key);
  @override
  _CustomerListState createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  List customerList = [];
  List columns = customerDetailColumns.where((element) => element["allowHistory"]).toList();
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
            : new Container(
                child: DataTable(
                  headingRowColor: MaterialStateColor.resolveWith(
                      (states) => Colors.green.withOpacity(0.3)),
                  columns: List.generate(
                    customerDetailColumns.length,
                    (index) {
                      return DataColumn(
                        label: Expanded(
                          child: Text(
                            customerDetailColumns[index]["label"],
                            style: TextStyle(fontStyle: FontStyle.italic),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  ),
                  rows: List.generate(
                    customerList.length,
                    (idx) {
                      var item = customerList[idx];
                      return DataRow(
                        color: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (idx % 2 == 0)
                              return Colors.green.withOpacity(0.1);
                            return Colors.green.withOpacity(0.2);
                          },
                        ),
                        cells: List.generate(
                          customerDetailColumns.length,
                          (index) {
                            return DataCell(Text("Hai"));
                          },
                        ),
                      );
                    },
                  ),
                  headingRowHeight: 50.0,
                  dataRowHeight: 40.0,
                ),
              ),
      ),
    );
  }
}
