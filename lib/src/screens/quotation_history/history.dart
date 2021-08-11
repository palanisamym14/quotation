import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quotation/src/modal/data_grid_repo.dart';
import 'package:intl/intl.dart';

final f = new DateFormat('yyyy-MM-dd');
class QuotationHistory extends StatefulWidget {
  const QuotationHistory({Key? key}) : super(key: key);
  @override
  _QuotationHistoryState createState() => _QuotationHistoryState();
}

class _QuotationHistoryState extends State<QuotationHistory> {
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
    loadInitData();
  }

  List actionItems = [
    {
      'name': 'Edit',
      'type': 'ETH',
      'icon': Icons.border_color_outlined,
      'iconColor': Colors.orange,
    },
    {
      'name': 'Preview',
      'type': 'ETH',
      'icon': Icons.table_view_outlined,
      'iconColor': Colors.black,
    },
    {
      'name': 'Copy',
      'type': 'copy',
      'icon': Icons.file_copy_outlined,
      'iconColor': Colors.green,
    },
    {
      'name': 'Share',
      'type': 'share',
      'icon': Icons.share_outlined,
      'iconColor': Colors.black,
    },
    {
      'name': 'Delete',
      'type': 'ETH',
      'icon': Icons.delete_forever_outlined,
      'iconColor': Colors.red,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: quotationHistory.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    height: 144,
                    width: double.maxFinite,
                    child: Card(
                      elevation: 5,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(width: 2.0, color: Colors.green),
                          ),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(7),
                          child: Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerRight,
                                child: Stack(
                                  children: <Widget>[
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 5),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                cryptoNameSymbol(
                                                    quotationHistory[index]),
                                                Spacer(),
                                                cryptoChange(
                                                    quotationHistory[index]),
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                actionIcons(
                                                    quotationHistory[index])
                                              ],
                                            )
                                          ],
                                        ))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    )));
  }

  Widget cryptoNameSymbol(data) {
    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          text: '${data['customerName']}',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
          children: <TextSpan>[
            TextSpan(
                text: '\n${data['mobile']}',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget cryptoChange(data) {
    return Align(
      alignment: Alignment.topRight,
      child: RichText(
        text: TextSpan(
          text:
              '${data["grandTotal"]}',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.green, fontSize: 20),
          children: <TextSpan>[
            TextSpan(
                text: '\n${f.format(new DateTime.fromMillisecondsSinceEpoch(data['createdDate']))}',
                style: TextStyle(
                    color: data['changeColor'],
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget actionIcons(data) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List<Widget>.generate(
            actionItems.length,
            (i) => InkWell(
              splashColor: Colors.green, // splash color
              onTap: () {}, // button pressed
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    actionItems[i]['icon'],
                    color: actionItems[i]['iconColor'],
                    size: 30,
                  ), // icon
                  Text(actionItems[i]["name"]), // text
                ],
              ),
            ),
          ).toList(),
        ),
      ),
    );
  }

  Widget cryptoAmount(data) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Row(
          children: <Widget>[
            RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                text: '\n${data['value']}',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 35,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: '\n0.1349',
                      style: TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
