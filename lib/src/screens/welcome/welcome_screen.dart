import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) {
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'User not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return "";
    });
  }

  Future<String> _authLogin(LoginData data) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: data.name, password: data.password);
      print(userCredential);
      return "";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return "";
    } catch (e) {
      print(e);
      return (e.toString());
    }
  }

  Future<String> _authSignUp(LoginData data) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: data.name, password: data.password);
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      await users.add({
        "id": userCredential.user!.uid,
        "uid": userCredential.user!.uid,
        "type": 0,
        "email": userCredential.user!.email
      });
      return "";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return ('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return ('The account already exists for that email.');
      }
      return "";
    } catch (e) {
      print(e);
      return (e.toString());
    }
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return "";
    });
  }

  @override
  void initState() {
    super.initState();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    if (user != null) {
      Modular.to.navigate('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Quotation',
      logo: 'assets/images/logo_white.png',
      onLogin: _authLogin,
      onSignup: _authSignUp,
      titleTag: "Thanks for sign up",
      loginProviders: <LoginProvider>[
        LoginProvider(
          icon: Icons.phone,
          label: 'Google',
          callback: () async {
            print('start google sign in');
            await Future.delayed(loginTime);
            print('stop google sign in');
            return null;
          },
        ),
        LoginProvider(
          icon: Icons.phone,
          label: 'Facebook',
          callback: () async {
            print('start facebook sign in');
            await Future.delayed(loginTime);
            print('stop facebook sign in');
            return null;
          },
        ),
      ],
      onSubmitAnimationCompleted: () {
        print("login Complete");
        Modular.to.navigate('/');
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
