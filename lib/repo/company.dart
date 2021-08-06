
import 'package:quotation/model/model.dart';

class CompanyRepo {
  Future<void> insertOrUpdate(TblCompany data) async {
    final product = TblCompany();
    product.companyName = data.companyName;
    if(data.id != null) {
      product.id = data.id;
    }
    await product.save();
  }

  Future<void> find() async {
    final product = TblCompany();
    var result = await product.select().toList();
    print(result);
    for (var row in result) {
      print(row.toMap());
    }
  }

  Future<TblCompany?> findByName(name) async {
    final product = TblCompany();
    var result = await product.select().companyName.not.equals(name).toList();
    if(result.length > 0){
      return result[0];
    }
    return null;
  }
}

