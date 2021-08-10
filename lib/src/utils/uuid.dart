import 'package:uuid/uuid.dart';

String getUuidV1() {
  var uuid = Uuid();
  return uuid.v1(options: {
    'node': [0x01, 0x23, 0x45, 0x67, 0x89, 0xab],
    'clockSeq': 0x1234,
    'mSecs': DateTime.now().millisecondsSinceEpoch,
    'nSecs': 5678
  });
}

getUuidV4() {
  var uuid = Uuid();
  return uuid.v4();
}


getUuidV5(String str) {
  var uuid = Uuid();
  return uuid.v5(Uuid.NAMESPACE_URL, str);
}