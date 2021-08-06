import 'package:quotation/model/model.dart'
    show
        TblCustomer,
        TblQuotation,
        TblQuotationHeader,
        TblQuotationSummary,
        DBQuotation;

class DataGridRepo {
  DataGridRepo();
  Future<int?> insertCustomerData(TblCustomer customer) async {
    TblCustomer _customer = new TblCustomer(
      companyName: customer.companyName,
      addressLine1: customer.addressLine1,
      addressLine2: customer.addressLine2,
      id: customer.id,
      mobile: customer.mobile,
      email: customer.email,
    );
    return await _customer.save();
  }

  Future<void> insertQuotationData(List<TblQuotation> quotations) async {
    int? quotationId = DateTime.now().millisecondsSinceEpoch;
    quotations.asMap().forEach((index, quotation) async {
      if (quotation.quotationHdrId != null) {
        quotationId = quotation.quotationHdrId;
      }
      TblQuotation _quotation = new TblQuotation(
        quantity: quotation.quantity,
        productId: quotation.productId,
        price: quotation.price,
        totalPrice: quotation.totalPrice,
        quotationHdrId: quotationId,
        sequenceNo: index,
      );
      await _quotation.save().then((value) => print(value));
    });
    TblQuotation _quotation = new TblQuotation();
    final _q = await _quotation.select().toList();
    print(_q);
    for (var q in _q) {
      print(q.toMap());
    }
  }

  Future<void> saveDataGrid(List<Map<String, dynamic>> gridData,
      Map<String, dynamic> tblCustomer, Map<String, dynamic> summary) async {
    TblCustomer _tblCustomer = new TblCustomer();
    _tblCustomer.companyName = tblCustomer["companyName"];
    _tblCustomer.mobile = tblCustomer["mobile"];
    _tblCustomer.addressLine1 = tblCustomer["addressLine1"];
    _tblCustomer.addressLine2 = tblCustomer["addressLine2"];
    _tblCustomer.email = tblCustomer["email"];
    int? customerId = await insertCustomerData(_tblCustomer);
    print(customerId);
    int? quotationHdrId =
        await new TblQuotationHeader(customerId: customerId).save();

    List<TblQuotation> quotations = [];
    gridData.forEach((element) {
      TblQuotation quotation = TblQuotation();
      quotation.quotationHdrId = quotationHdrId;
      quotation.price = element["price"];
      quotation.quantity = element["quantity"];
      quotation.totalPrice = element["totalPrice"];
      quotation.productId = element["productId"] ?? null;
      quotations.add(quotation);
    });

    TblQuotationSummary tblQuotationSummary = new TblQuotationSummary();
    tblQuotationSummary.discount = summary["discount"];
    tblQuotationSummary.netPay = summary["netPay"];
    tblQuotationSummary.grandTotal = summary["grandTotal"];
    tblQuotationSummary.quotationHdrId = quotationHdrId;
    await insertQuotationData(quotations);
    // List<TblQuotation> _quotations = await new TblQuotation().select().toList();
    List<dynamic>? _quotations = await DBQuotation().execDataTable(
        'SELECT * FROM quotation INNER JOIN quotationHdr ON quotationHdr.id = quotation.quotationHdrId LIMIT 100')??[];
    print(_quotations);
    _quotations.forEach((element) { print(element);});
  }
}
