import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:quotation/src/screens/company_details/company_details.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  Future<void> getCurrentUser() async {
    User? _user = _auth.currentUser;
    setState(() {
      user = _user;
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: ListView(
        children: <Widget>[
          //Set User Information Username Avatar
          UserAccountsDrawerHeader(
            accountName: new Text(user!.displayName ?? ''),
            accountEmail: new Text(user!.email ?? ''),
            //Current avatar
            currentAccountPicture: new CircleAvatar(
              backgroundColor: Colors.green,
              backgroundImage: new AssetImage("assets/images/main_bottom.png"),
            ),
            onDetailsPressed: () {},
            //Other account avatars
            otherAccountsPictures: <Widget>[
              new Container(
                child: Image.asset("assets/images/main_top.png"),
              )
            ],
          ),
          ListTile(
            leading: new CircleAvatar(
              backgroundColor: Colors.green,
              child: new Icon(
                Icons.dashboard_sharp,
                color: Colors.white,
              ),
            ),
            title: Text("Company Detail"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CompanyDetailsScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: new CircleAvatar(
              backgroundColor: Colors.green,
              child: new Icon(
                Icons.dashboard_sharp,
                color: Colors.white,
              ),
            ),
            title: Text("Dashboard"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CompanyDetailsScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: new CircleAvatar(
              backgroundColor: Colors.green,
              child: new Icon(
                Icons.settings_sharp,
                color: Colors.white,
              ),
            ),
            title: new Text("Settings"),
          ),
          ListTile(
            leading: new CircleAvatar(
              backgroundColor: Colors.green,
              child: new Icon(
                Icons.logout_rounded,
                color: Colors.white,
              ),
            ),
            title: new Text("Logout"),
            onTap: (){
              _auth.signOut().then((value){
                Modular.to.navigate('login');
              });
            },
          )
        ],
      ),
    );
  }
}
