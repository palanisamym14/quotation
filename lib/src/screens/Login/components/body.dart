
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quotation/src/Screens/Login/components/background.dart';
import 'package:quotation/src/screens/Login/components/form.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);
  @override
  _LoginBodyState createState() => new _LoginBodyState();
}

class _LoginBodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            LoginForm(),
          ],
        ),
      ),
    );
  }
}
