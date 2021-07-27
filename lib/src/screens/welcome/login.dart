import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:graphql/client.dart';
import '../../utils/graphql_client.dart';
import 'welcome.graphql.dart';

// import 'dashboard_screen.dart';


class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<dynamic> validateUser() async {
     getAllUserQuery();
  }

  Future<String> _authUser(LoginData data) async {
    print('Name: ${data.name}, Password: ${data.password}');
    List<dynamic> users = await this.validateUser();
    return Future.delayed(loginTime).then((_) {
      dynamic userExits = users.where((ele) => ele['email'] == data.name);
      print(userExits);
      if (userExits.length) {
        return 'User Already exists';
      }
      return 'Password does not match';
      // if (users[data.name] != data.password) {
      // }
      // return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      // if (!users.containsKey(name)) {
      // }
      return 'User not exists';
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'SMART CLASS ROOMS',
      logo: 'assets/images/ecorp-lightblue.png',
      onLogin: _authUser,
      onSignup: _authUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Text(''),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
