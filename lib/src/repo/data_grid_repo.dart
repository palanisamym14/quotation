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
    tblQuotationSummary.id = getUuidV1();
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
    await getQuotationHistory();
  }

  getQuotationHistory() async {
    const query =
        'select customer.name as customerName, customer."addressLine1", customer."addressLine2", customer. mobile, customer.email, "quotationHdr".*, "quotationSummary".id as summeryId, "quotationSummary"."netPay", "quotationSummary"."grandTotal", "quotationSummary".wages, "quotationSummary".discount from customer inner join  "quotationHdr" on "quotationHdr"."customerId" = customer.id inner join "quotationSummary" on "quotationSummary"."quotationHdrId" = "quotationHdr".id where "quotationHdr"."isDeleted" !=1  order by createdDate desc';
    List<dynamic>? _quotations = await DBQuotation().execDataTable(query) ?? [];
    return _quotations;
  }

  Future<Map<String, dynamic>> loadQuotationData(String quotationId) async {
    var _quotationHeader = await new TblQuotationHeader()
        .select(columnsToSelect: ["customerId"])
        .id
        .equals(quotationId)
        .toSingle();
    print("_quotationHeader");
    if (_quotationHeader != null) {
      var customer = await new TblCustomer()
          .select()
          .id
          .equals(_quotationHeader.customerId)
          .toSingle();
      print(customer?.toMap());
      var footer = await new TblQuotationSummary()
          .select()
          .quotationHdrId
          .equals(quotationId)
          .toSingle();
      print(footer?.toMap());
      const query =
          'select quotation.*, product.description, product.id  from product inner join  quotation on quotation."productId" = product.id inner join quotationHdr on "quotationHdr".id = quotation."quotationHdrId" where quotation."quotationHdrId" = \':val\'  and "quotationHdr"."isDeleted" !=1 order by "sequenceNo" desc';
      List<dynamic>? _quotations = await DBQuotation()
              .execDataTable(query.replaceAll(':val', quotationId)) ??
          [];
      var quotation = await new TblQuotation()
          .select()
          .quotationHdrId
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
