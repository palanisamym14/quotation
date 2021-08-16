import 'package:quotation/model/model.dart'
    show
        TblCustomer,
        TblQuotation,
        TblItems,
        TblQuotationSummary,
        TblProduct,
        DBQuotation;
import 'package:quotation/src/repo/db_query.dart' as DBQuery;
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
        if (_tblCust != null) {
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
      print(gridData);
      print("gridData");
      gridData.forEach((element) async {
        TblItems items = TblItems();
        items.quotationId = hdrId;
        items.id = getUuidV1();
        items.price = element["price"];
        items.quantity = element["quantity"];
        items.totalPrice = element["totalPrice"];
        items.productId = element["productId"] ?? null;
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
            items.productId = productId;
          } else {
            items.productId = _tblProduct.id;
          }
        }
        BoolResult result = await items.save();
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
    tblQuotationSummary.quotationId = hdrId;
    tblQuotationSummary.id = getUuidV1();
    await tblQuotationSummary.save();
  }

  Future<void> saveDataGrid(List<Map<String, dynamic>> gridData,
      Map<String, dynamic> tblCustomer, Map<String, dynamic> summary) async {
    String customerId = await insertCustomerData(tblCustomer);
    String hdrId = getUuidV1();
    await TblQuotation(customerId: customerId, id: hdrId).save();
    await insertQuotationData(gridData, hdrId);
    await insertSummaryData(summary, hdrId);
    await getQuotationHistory();
  }

  getQuotationHistory() async {
    String query = DBQuery.selectQuotationHistory;
    List<dynamic>? _quotations = await DBQuotation().execDataTable(query) ?? [];
    return _quotations;
  }

  Future<Map<String, dynamic>> loadQuotationData(String quotationId) async {
    var _quotation = await new TblQuotation()
        .select(columnsToSelect: ["customerId"])
        .id
        .equals(quotationId)
        .toSingle();
    if (_quotation != null) {
      var customer = await new TblCustomer()
          .select()
          .id
          .equals(_quotation.customerId)
          .toSingle();
      print(customer?.toMap());
      var footer = await new TblQuotationSummary()
          .select()
          .quotationId
          .equals(quotationId)
          .toSingle();
      print(footer?.toMap());
      String query = DBQuery.selectQuotationById;
      List<dynamic>? _quotations = await DBQuotation()
              .execDataTable(query.replaceAll(':val', quotationId)) ??
          [];
      var quotation = await new TblItems()
          .select()
          .quotationId
          .equals(quotationId)
          .toMapList();
      print(_quotations);
      return {
        "summary": footer?.toMap(),
        "customer": customer?.toMap(),
        "quotation": _quotations,
      };
    }
    return {};
  }
}
