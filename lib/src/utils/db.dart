import 'package:quotation/model/model.dart';

class Db {
  Db();
  factory Db.create() {
    _dB = Db();
    return _dB;
  }
  static Db _dB = Db();
  static bool _isConnected = false;

  Future<bool> connect() async {
    if (_isConnected == false)
      try {
        _isConnected = await DBQuotation().initializeDB();
        final path = DBQuotation().getDatabasePath();
        print("**************");
        print("**************");
        print(path);
        print("**************");
        print("**************");
      } on Exception catch (err) {
        print("DbTag");
        print(err);
        print("DbTag");
      }
    return _isConnected;
  }
}
