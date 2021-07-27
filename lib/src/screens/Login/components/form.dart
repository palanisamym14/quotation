import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:quotation/src/components/already_have_an_account_acheck.dart';
import 'package:quotation/src/components/rounded_input_field.dart';
import 'package:quotation/src/components/rounded_password_field.dart';
import 'package:quotation/src/screens/Login/components/api.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Map<String, String> _loginObject = Map<String, String>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildLoginForm(),
    );
  }

  Widget _buildLoginForm() {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RoundedInputField(
                      hintText: "Your Email",
                      validator: EmailValidator(
                          errorText: 'enter a valid email address'),
                      name: "email",
                      setValue: _loginObject),
                  RoundedPasswordField(
                      name: "password", setValue: _loginObject),
                  registerButton(),
                  SizedBox(height: size.height * 0.03),
                ],
              ),
            ),
          ),
          AlreadyHaveAnAccountCheck(
            press: () {
              Modular.to.pushNamed('/signup');
            },
          ),
        ],
      ),
    );
  }

  Widget registerButton() {
    return ElevatedButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          print(JsonEncoder().convert(_loginObject));
          signIn(_loginObject, context);
        }
      },
      child: Text('Login'),
    );
  }

  Future<dynamic> signIn(_loginObject, context) async {
    var response = await loginUser(_loginObject);
    if (response["hasError"]) {
      _showToast(context, response["error"]);
    } else {
      Modular.to.pushNamed('/home');
    }
  }

  void _showToast(BuildContext context, data) {
    final scaffold = ScaffoldMessenger.of(context);
    final msg = data["message"];
    scaffold.showSnackBar(
      SnackBar(
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
        content: Text(msg ?? 'Error'),
        backgroundColor: Color.fromARGB(255, 241, 75, 47),
      ),
    );
  }
}
