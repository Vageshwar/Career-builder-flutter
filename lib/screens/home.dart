import 'package:career_builder/screens/homeMenus/applied.dart';
import 'package:career_builder/screens/homeMenus/companies.dart';
import 'package:career_builder/screens/homeMenus/navbar_item.dart';
import 'package:career_builder/screens/homeMenus/profile.dart';
import 'package:career_builder/screens/login_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int i = 0;
  List<Widget> fragment = [];
  @override
  Widget build(BuildContext context) {
    fragment = [
      Profile(),
      Applications(),
      Companies(),
    ];
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('Are you sure you want to exit?'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('No'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  FlatButton(
                    child: Text('Yes, exit'),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              );
            });

        return value == true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Career Builder",
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          backgroundColor: Colors.red,
          elevation: 5.0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Container(
                  child: Image(
                      image: AssetImage('images/logo.png'),
                      height: 50,
                      width: 50)),
            ),
          ],
        ),
        body: fragment[i],
        drawer: NavigationDrawer(onTap: (context, index) {
          Navigator.pop(context);
          setState(() {
            i = index;
          });
        }),
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  final Function onTap;

  NavigationDrawer({this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.redAccent,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 16),
        ],
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 100,
          ),
          Divider(
            color: Colors.white,
          ),
          ListTile(
            title: NavBarItem("My Profile"),
            leading: Icon(
              Icons.format_align_center,
              color: Colors.white,
              size: 30,
            ),
            onTap: () => onTap(context, 0),
          ),
          Divider(
            color: Colors.white,
          ),
          ListTile(
            title: NavBarItem("Applications"),
            leading: Icon(
              Icons.timeline,
              color: Colors.white,
              size: 30,
            ),
            onTap: () => onTap(context, 1),
          ),
          Divider(
            color: Colors.white,
          ),
          ListTile(
            title: NavBarItem("Comapanies"),
            leading: Icon(
              Icons.local_hospital_sharp,
              color: Colors.white,
              size: 30,
            ),
            onTap: () => onTap(context, 2),
          ),
          Divider(
            color: Colors.white,
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            title: Text("Log Out",
                style: TextStyle(fontSize: 20, color: Colors.white)),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return Login();
              }));
            },
          )
        ],
      ),
    );
  }
}
