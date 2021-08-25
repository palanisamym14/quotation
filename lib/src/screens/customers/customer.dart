import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quotation/src/repo/customer_repo.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quotation/src/screens/customers/customer_detail.dart';
import 'package:quotation/src/screens/dataGrid/grid_constant.draft.dart';

final f = new DateFormat('yyyy-MM-dd');
final quotationFormat = new DateFormat('d-H-m-s');

class CustomerList extends StatefulWidget {
  final BuildContext context;
  const CustomerList({Key? key, required this.context}) : super(key: key);
  @override
  _CustomerListState createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  List customerList = [];
  List columns = customerDetailColumns
      .where((element) => element["allowHistory"])
      .toList();
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
            : ListView.builder(
                itemCount: customerList.length,
                itemBuilder: (context, index) {
                  var _model = customerList[index];
                  print(_model);
                  return Column(
                    children: <Widget>[
                      Divider(
                        height: 12.0,
                      ),
                      ListTile(
                        leading: new CircleAvatar(
                          radius: 24.0,
                          backgroundColor: Colors.green,
                          backgroundImage:
                              new AssetImage('assets/images/boy.png'),
                        ),
                        title: Row(
                          children: <Widget>[
                            Text(_model["name"]),
                          ],
                        ),
                        subtitle: Text(_model["mobile"]),
                        trailing: IconButton(
                            icon: const Icon(Icons.arrow_forward_ios),
                            onPressed: () {
                              onViewCustomerButtonPressed(context, _model);
                            },),
                      ),
                    ],
                  );
                },
              ),
      ),
    );
  }

  onViewCustomerButtonPressed(context, customer) async {
    final result = await Navigator.push(
      widget.context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(
        builder: (context) => new Scaffold(
          body: CustomerDetailContainer(customer: customer),
        ),
      ),
    );
  }
}
