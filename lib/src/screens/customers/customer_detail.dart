import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quotation/src/screens/quotation_history/history.dart';

class CustomerDetailContainer extends StatelessWidget {
  final Map<String, dynamic> customer;
  const CustomerDetailContainer({Key? key, required this.customer})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Detail"),
      ),
      body: CustomScrollView(
        slivers: [
          // SliverPersistentHeader(
          //   pinned: false,
          //   delegate: MyDynamicHeader(),
          // ),
          SliverFillRemaining(
              child: QuotationHistory(customerId: customer["id"]))
        ],
        // QuotationHistory(customerId:customer["id"]),
      ),
    );
  }
}

class MyDynamicHeader extends SliverPersistentHeaderDelegate {
  int index = 0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return LayoutBuilder(builder: (context, constraints) {
      final Color color = Colors.primaries[index];
      final double percentage =
          (constraints.maxHeight - minExtent) / (maxExtent - minExtent);

      if (++index > Colors.primaries.length - 1) index = 0;

      return Container(
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(blurRadius: 4.0, color: Colors.black45)],
            gradient: LinearGradient(colors: [Colors.blue, color])),
        height: constraints.maxHeight,
        child: SafeArea(
            child: Center(
          child: CircularProgressIndicator(
            value: percentage,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        )),
      );
    });
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate _) => true;

  @override
  double get maxExtent => 250.0;

  @override
  double get minExtent => 80.0;
}
