import 'package:quotation/model/model.dart'
    show
        TblCustomer,
        TblQuotation,
        TblQuotationHeader,
        TblQuotationSummary,
        TblProduct,
        DBQuotation;
import 'package:quotation/src/utils/uuid.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

class DataGridRepo {
  DataGridRepo();
  Future<String> insertCustomerData(Map<String, dynamic> tblCustomer) async {
    try {
      TblCustomer _tblCustomer = new TblCustomer();
      String? customerId = tblCustomer['id'] ?? getUuidV1();
      if (tblCustomer['id'] == null) {
        var _tblCust = await _tblCustomer
            .select()
            .name
            .equals(tblCustomer["name"])
            .or
            .mobile
            .equals(tblCustomer['mobile'])
            .toSingle();
        if (_tblCust!.id != null) {
          customerId = _tblCust.id;
        }
      }
      _tblCustomer.id = customerId;
      _tblCustomer.name = tblCustomer["name"];
      _tblCustomer.mobile = tblCustomer["mobile"];
      _tblCustomer.addressLine1 = tblCustomer["addressLine1"];
      _tblCustomer.addressLine2 = tblCustomer["addressLine2"];
      _tblCustomer.email = tblCustomer["email"];
      await _tblCustomer.save();
      return customerId ?? getUuidV1();
    } on Exception catch (err) {
      print(err);
      return "";
    }
  }

  Future<void> insertQuotationData(
      List<Map<String, dynamic>> gridData, hdrId) async {
    try {
      gridData.forEach((element) async {
        TblQuotation quotation = TblQuotation();
        quotation.quotationHdrId = hdrId;
        quotation.id = getUuidV1();
        quotation.price = element["price"];
        quotation.quantity = element["quantity"];
        quotation.totalPrice = element["totalPrice"];
        quotation.productId = element["productId"] ?? null;
        if (element["productId"] == null) {
          TblProduct tblProduct = new TblProduct();
          var _tblProduct = await tblProduct
              .select()
              .description
              .equals(element["description"])
              .toSingle();
          if (_tblProduct == null) {
            String productId = getUuidV1();
            tblProduct.id = productId;
            tblProduct.description = element["description"];
            BoolResult res = await tblProduct.save();
            quotation.productId = productId;
          } else {
            quotation.productId = _tblProduct.id;
          }
        }
        BoolResult result = await quotation.save();
      });
    } on Exception catch (err) {
      print(err);
    }
  }

  Future<void> insertSummaryData(Map<String, dynamic> summary, hdrId) async {
    TblQuotationSummary tblQuotationSummary = new TblQuotationSummary();
    tblQuotationSummary.discount = summary["discount"];
    tblQuotationSummary.netPay = summary["netPay"];
    tblQuotationSummary.grandTotal = summary["grandTotal"];
    tblQuotationSummary.quotationHdrId = hdrId;
    await tblQuotationSummary.save();
  }

  Future<void> saveDataGrid(List<Map<String, dynamic>> gridData,
      Map<String, dynamic> tblCustomer, Map<String, dynamic> summary) async {
    String customerId = await insertCustomerData(tblCustomer);
    String hdrId = getUuidV1();
    await TblQuotationHeader(customerId: customerId, id: hdrId).save();
    await insertQuotationData(gridData, hdrId);
    await insertSummaryData(summary, hdrId);
    String query =
        'select * from quotation INNER JOIN quotationHdr on quotation.quotationHdrId = quotationHdr.id  INNER JOIN product on product.id = quotation.productId where  quotationHdr.id = \'$hdrId\'  LIMIT 100';
    List<dynamic>? _quotations = await DBQuotation().execDataTable(query) ?? [];
    print(_quotations.length);
    _quotations.forEach((element) {
      print(element);
    });
  }
}
