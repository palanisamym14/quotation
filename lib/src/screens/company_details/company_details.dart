import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quotation/src/components/add_item.dart';
import 'package:quotation/src/components/spinner_body.dart';
import 'package:quotation/src/modal/company_repo.dart';
import 'package:quotation/src/screens/company_details/company_constant.dart';
import 'dart:core';
import 'package:quotation/src/modal/user_repo.dart' as userRepo;

class CompanyDetailsScreen extends StatefulWidget {
  const CompanyDetailsScreen({Key? key}) : super(key: key);

  @override
  _CompanyDetailsScreenState createState() => _CompanyDetailsScreenState();
}

class _CompanyDetailsScreenState extends State<CompanyDetailsScreen> {
  Map<String, dynamic> stringParams = {
    "description": '',
  };
  bool isLoaded = false;

  Future<void> updateCompany(data) async {
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference company =
    FirebaseFirestore.instance.collection("company");
    company.doc(user!.uid).set(data);
    new CompanyRepo().updateCompany(data);
    Navigator.pop(context, true);
  }

  Future<void> initData() async {
    try {
      Map<String, dynamic> companyInfo = await new CompanyRepo().getCompany();
      setState(() {
        formColumns.forEach((element) {
          var _key = element["_key"];
          stringParams[_key] = companyInfo[_key];
        });
        isLoaded = true;
      });
    } on Exception catch (e) {
      setState(() {
        isLoaded = true;
      });
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    initData();
    // isLoaded=true;
    print("userRepo.userId");
    print(userRepo.userId);
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded
        ? AddItemForm(
        columns: formColumns,
        initValues: stringParams,
        header: "Company Details",
        actionLabel: 'Add',
        isCallBack: true,
        callBack: updateCompany)
        : SpinnerBody();
  }
}

