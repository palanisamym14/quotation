import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quotation/src/modal/user_repo.dart';

final auth = FirebaseFirestore.instance;

class CompanyRepo {
  Future<Map<String, dynamic>> getCompany() async {
    DocumentSnapshot company =
        await auth.collection("company").doc(userId).get();
    var data = company.data();
    return data == null ? {} : data as Map<String, dynamic>;
  }

  updateCompany(data) {
    CollectionReference company =
        FirebaseFirestore.instance.collection("company");
    company.doc(userId).set(data);
    print(data);
    // return data;
  }

}
