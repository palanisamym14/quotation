import 'package:quotation/model/model.dart';

class ProductRepo {
  Future<void> insert() async {
    final product = Product();
    product.name = "Processor";
    var key = await product.save();
    print(key);
  }

  Future<void> find() async {
    final product = Product();
    var result = await product.select().toList();
    print(result);
    for (var row in result) {
      print(row.toMap());
    }
  }
}
