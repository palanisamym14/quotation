import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quotation/src/repo/customer_repo.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quotation/src/screens/customers/customer_data_source.dart';
import 'package:quotation/src/screens/dataGrid/grid_constant.draft.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

final f = new DateFormat('yyyy-MM-dd');
final quotationFormat = new DateFormat('d-H-m-s');

class CustomerList extends StatefulWidget {
  const CustomerList({Key? key}) : super(key: key);
  @override
  _CustomerListState createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  late CustomerDataSource customerDataSource;
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
        customerDataSource = new CustomerDataSource(customerList);
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
                child: SfDataGrid(
                  columnWidthMode: ColumnWidthMode.fill,
                  source: customerDataSource,
                  allowSwiping: true,
                  swipeMaxOffset: 121.0,
                  startSwipeActionsBuilder: _buildStartSwipeWidget,
                  endSwipeActionsBuilder: _buildStartSwipeWidget,
                  columns: new List.generate(
                    customerDetailColumns.length,
                    (index) {
                      var column = customerDetailColumns[index];
                      return GridColumn(
                        columnName: column["_key"],
                        label: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            column["label"],
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
      ),
    );
  }
  Widget _buildStartSwipeWidget(BuildContext context, DataGridRow row, int index) {
    print(index);
    return GestureDetector(
      onTap: () => _handleEditWidgetTap(row),
      child: Container(
        color: Colors.green,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Icon(Icons.edit, color: Colors.white, size: 20),
            SizedBox(width: 16.0),
            Text(
              'EDIT',
              style: TextStyle(color: Colors.white, fontSize: 15),
            )
          ],
        ),
      ),
    );
  }

  _handleEditWidgetTap(DataGridRow row) {
    print(row.getCells());
  }
}
