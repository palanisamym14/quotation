import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:quotation/src/components/drawer.dart';

final padding = EdgeInsets.symmetric(horizontal: 18, vertical: 12);
double gap = 10;
List<String> routes = ['history', 'quotation', 'favourite', 'analysis'];
List<Color> colors = [Colors.purple, Colors.pink, Colors.purple, Colors.teal];

class BottomNavBar extends StatefulWidget {
  final Widget? body;
  BottomNavBar({this.body});
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
      final FirebaseAuth _auth = FirebaseAuth.instance;
      User? user = _auth.currentUser;
      print(user);
      print("user");
      if (user != null) {
        Modular.to.navigate(routes[0]);
      }else{
        Modular.to.navigate('login');
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: this.widget.body,
      appBar: AppBar(
        title: Text(routes[_selectedIndex]),
      ),
      drawer: CustomDrawer(),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(100)),
            boxShadow: [
              BoxShadow(
                spreadRadius: -10,
                blurRadius: 60,
                color: Colors.black.withOpacity(.4),
                offset: Offset(0, 25),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 3),
            child: GNav(
              tabs:[
                GButton(
                  gap: gap,
                  iconActiveColor: Colors.purple,
                  iconColor: Colors.black,
                  textColor: Colors.purple,
                  backgroundColor: Colors.purple.withOpacity(.2),
                  iconSize: 24,
                  padding: padding,
                  icon: LineIcons.home,
                  text: 'History',
                ),
                GButton(
                  gap: gap,
                  iconActiveColor: Colors.amber[600],
                  iconColor: Colors.black,
                  textColor: Colors.amber[600],
                  backgroundColor: Colors.amber[600]!.withOpacity(.2),
                  iconSize: 24,
                  padding: padding,
                  icon: LineIcons.calendarCheck,
                  text: 'Products',
                ),
                GButton(
                  gap: gap,
                  iconActiveColor: Colors.pink,
                  iconColor: Colors.black,
                  textColor: Colors.pink,
                  backgroundColor: Colors.pink.withOpacity(.2),
                  iconSize: 24,
                  padding: padding,
                  icon: LineIcons.heart,
                  text: 'Customer',
                ),
                GButton(
                  gap: gap,
                  iconActiveColor: Colors.teal,
                  iconColor: Colors.black,
                  textColor: Colors.teal,
                  backgroundColor: Colors.teal.withOpacity(.2),
                  iconSize: 24,
                  padding: padding,
                  icon: LineIcons.playstation,
                  text: 'Report',
                )
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
                Modular.to.navigate(routes[index]);
                // controller.jumpToPage(index);
              },
            ),
          ),
        ),
      ),
    );
  }
}
