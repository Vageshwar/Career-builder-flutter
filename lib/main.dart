import 'dart:async';

import 'package:career_builder/screens/home.dart';
import 'package:career_builder/screens/login_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Career Builder',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashTime(),
    );
  }
}

class SplashTime extends StatefulWidget {
  @override
  _Splash createState() => _Splash();
}

//State class for Splash Screen
class _Splash extends State<SplashTime> {
  var user;
  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    //Time of 2 sec for splash screen
    Timer(
        Duration(seconds: 2),
        () => Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              if (user == null) {
                return Login();
              } else
                return Home();
            })));
    //Logo
    var image = Image.asset(
        'images/logo.png'); //<- Creates a widget that displays an image.
    //return with white background and logo
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: new BoxDecoration(color: Color.fromARGB(255, 155, 21, 7)),
          child: Center(child: image),
        ), //<- place where the image appears
      ),
    );
  }
}
