import 'package:quotation/model/model.dart';

class ProductRepo {
  Future<void> insert() async {
    final product = TblProduct();
    product.description = "Processor";
    var key = await product.save();
    print(key);
  }

  Future<void> find() async {
    final product = TblProduct();
    var result = await product.select().toList();
    print(result);
    for (var row in result) {
      print(row.toMap());
    }
  }
}