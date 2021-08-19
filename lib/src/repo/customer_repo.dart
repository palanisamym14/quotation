import 'package:quotation/model/model.dart'
    show
    TblCustomer,
    DBQuotation;
import 'package:quotation/src/repo/db_query.dart' as DBQuery;
import 'package:quotation/src/utils/uuid.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

class CustomerRepo {
  CustomerRepo();

  getCustomerHistory() async {
    List<dynamic>? _customers = await TblCustomer().select().toListObject();
    return _customers;
  }

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

}
