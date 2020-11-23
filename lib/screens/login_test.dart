import 'package:career_builder/database/db.dart';
import 'package:career_builder/screens/forms/mainRegister.dart';
import 'package:flutter/material.dart';
import 'package:career_builder/screens/home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email, pass;
  bool _on = true;
  IconData _onEye = Icons.visibility_off;
  Widget _buildEmail() {
    return Theme(
      data: ThemeData(primaryColor: Colors.blue),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: "Email",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.mail),
          labelText: ("Email"),
        ),
        validator: (String value) {
          if (value != "" || value != null) {
            RegExp re = new RegExp(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$');
            if (!re.hasMatch(value)) return "Please Enter Valid Email";
          }
          return null;
        },
        onSaved: (value) {
          email = value;
        },
      ),
    );
  }

  Widget _buildPass() {
    return Theme(
      data: ThemeData(primaryColor: Colors.blue),
      child: TextFormField(
        maxLength: 10,
        obscureText: _on,
        decoration: InputDecoration(
          hintText: "Password",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(_onEye),
            onPressed: () {
              setState(() {
                _on = !_on;
                if (_on) {
                  _onEye = Icons.visibility_off;
                } else
                  _onEye = Icons.visibility;
              });
            },
          ),
          labelText: ("Password"),
        ),
        validator: (String value) {
          // ignore: unrelated_type_equality_checks
          if (value.isEmpty) {
            return 'This is Required';
          }
          if (value.length < 6) {
            return "Too Short";
          }

          return null;
        },
        onSaved: (value) {
          pass = value;
        },
      ),
    );
  }

  void _loginPressed() async {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();

    DB db = new DB();
    var rt = await db.loginEmailPassword(email, pass);
    //var rt = null;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 10,
                ),
                Text("Loading")
              ],
            ),
          ),
        );
      },
    );
    new Future.delayed(new Duration(seconds: 3), () {
      //Navigator.pop(context);
      //rt = true; //pop dialog
      if (rt) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) {
          return Home();
        }), (route) => false);
      } else {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: Padding(
                padding: EdgeInsets.all(25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [Text("Invalid Credentials")],
                ),
              ),
            );
          },
        );
      }
    });
  }

  void _createAccountPressed() {
    print('Redirect to Registeration Page');
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return MainRegistration();
    }));
  }

  Widget _buildButtons() {
    return Container(
      child: Column(
        children: [
          new RaisedButton(
            padding: EdgeInsets.fromLTRB(150, 15, 150, 15),
            color: Colors.blue,
            child: new Text(
              'Login',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: _loginPressed,
          ),
          new FlatButton(
            child: new Text('Dont have an account? Tap here to register.'),
            onPressed: _createAccountPressed,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
        body: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildEmail(),
                SizedBox(
                  height: 25,
                ),
                _buildPass(),
                SizedBox(
                  height: 25,
                ),
                _buildButtons()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
