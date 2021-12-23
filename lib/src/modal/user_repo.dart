
import 'dart:io';
import 'dart:math';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String userId = new UserFireBaseRepo().getUser();

class UserFireBaseRepo {
  String getUser() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user!.uid != null) {
      return user.uid;
    }
    return "";
  }
}
