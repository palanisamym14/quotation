import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: ListView(
        children: <Widget>[
          //Set User Information Username Avatar
          UserAccountsDrawerHeader(
            accountName: new Text("Palani"),
            accountEmail: new Text("palanisamym14@email.com"),
            //Current avatar
            currentAccountPicture: new CircleAvatar(
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
              child: new Icon(Icons.dashboard),
            ),
            title: Text("Dashboard"),
          ),
          Expanded(child: Container()),
          ListTile(
            leading: new CircleAvatar(
              child: new Icon(Icons.logout_outlined),
            ),
            title: new Text("Settings"),
          ),ListTile(
            leading: new CircleAvatar(
              child: new Icon(Icons.logout_outlined),
            ),
            title: new Text("Logout"),
          )
        ],
      ),
    );
  }
}
