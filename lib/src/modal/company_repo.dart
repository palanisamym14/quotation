import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quotation/src/modal/user_repo.dart';

final auth = FirebaseFirestore.instance;

class CompanyRepo {
  Future<Map<String, dynamic>> getCompany() async {
    DocumentSnapshot company = await auth.collection("company").doc(userId).get();
    return company.data() as Map<String, dynamic>;
  }
}
