import 'package:career_builder/database/db.dart';
import 'package:career_builder/screens/forms/academics.dart';
import 'package:flutter/material.dart';
import 'package:career_builder/modals/student.dart';

class MainRegistration extends StatefulWidget {
  @override
  _MainRegistrationState createState() => _MainRegistrationState();
}

class _MainRegistrationState extends State<MainRegistration> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String pass, cPass, gender = "Male";
  Student student;

  Widget _buildGender() {
    return Theme(
      data: ThemeData(primaryColor: Colors.blue),
      child: DropdownButtonFormField(
          decoration: InputDecoration(
            hintText: "Gender",
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 16.0,
            ),
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.people),
            labelText: ("Gender"),
          ),
          items: ["Male", "Female", "Other"]
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ))
              .toList(),
          onChanged: (String selected) {
            setState(() {
              gender = selected;
              print(gender);
            });
          }),
    );
  }

  Widget _buildFName() {
    return Theme(
      data: ThemeData(primaryColor: Colors.blue),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "First Name",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.perm_identity),
          labelText: ("First Name"),
        ),
        validator: (String value) {
          // ignore: unrelated_type_equality_checks
          if (value.isEmpty) {
            return 'First Name is Required';
          }
          RegExp re = new RegExp(r'/^[A-Za-z]+$/');
          if (re.hasMatch(value)) return "Please Enter Alphabets";

          return null;
        },
        onSaved: (value) {
          student.fName = value;
        },
      ),
    );
  }

  Widget _buildLName() {
    return Theme(
      data: ThemeData(primaryColor: Colors.blue),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "Last Name",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.perm_identity),
          labelText: ("Last Name"),
        ),
        validator: (String value) {
          // ignore: unrelated_type_equality_checks
          if (value.isEmpty) {
            return 'This is Required';
          }
          // RegExp re = new RegExp(r'/^[A-Za-z]+$/');
          // if (re.hasMatch(value)) return "Please Enter Alphabets";

          return null;
        },
        onSaved: (value) {
          student.lName = value;
        },
      ),
    );
  }

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
          student.email = value;
        },
      ),
    );
  }

  Widget _buildPass() {
    return Theme(
      data: ThemeData(primaryColor: Colors.blue),
      child: TextFormField(
        maxLength: 10,
        obscureText: true,
        decoration: InputDecoration(
          hintText: "Password",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.lock),
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

  Widget _buildCPass() {
    return Theme(
      data: ThemeData(primaryColor: Colors.blue),
      child: TextFormField(
        maxLength: 10,
        obscureText: true,
        decoration: InputDecoration(
          hintText: "Confirm Password",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.lock),
          labelText: ("Confirm Password"),
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
          cPass = value;
        },
      ),
    );
  }

  Widget _buildCollege() {
    return Theme(
      data: ThemeData(primaryColor: Colors.blue),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "College Name",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.school),
          labelText: ("College Name"),
        ),
        validator: (String value) {
          // ignore: unrelated_type_equality_checks
          if (value.isEmpty) {
            return 'College Name is Required';
          }
          // RegExp re = new RegExp(r'/^[A-Za-z]+$/');
          // if (!re.hasMatch(value)) return "Please Enter Alphabets";

          return null;
        },
        onSaved: (value) {
          student.college = value;
        },
      ),
    );
  }

  Widget _buildRollNumber() {
    return Theme(
      data: ThemeData(primaryColor: Colors.blue),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: "College Roll Number",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.notes),
          labelText: ("College Roll Number"),
        ),
        validator: (String value) {
          // ignore: unrelated_type_equality_checks
          if (value.isEmpty) {
            return 'This is Required';
          }
          RegExp re = new RegExp(r'^\d*\.?\d*$');
          if (!re.hasMatch(value)) return "Please Enter Numerics";

          return null;
        },
        onSaved: (value) {
          student.prn = value;
        },
      ),
    );
  }

  void _register() {
    student = Student();
    student.gender = gender;
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    if (pass != cPass) {
      Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      AlertDialog alert = AlertDialog(
        title: Text("Error"),
        content: Text("Password mismatched"),
        actions: [
          okButton,
        ],
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
      return;
    }

    DB db = DB();
    var rt = db.createStudent(pass, student);
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
      if (rt != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AcademicsForm();
        }));
      }
    });
  }

  Widget _buildButtons() {
    return Container(
      child: Column(
        children: [
          new RaisedButton(
            padding: EdgeInsets.fromLTRB(120, 15, 120, 15),
            color: Colors.blue,
            child: new Text(
              'Register',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: _register,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Personal Details",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                _buildFName(),
                SizedBox(height: 10),
                _buildLName(),
                SizedBox(height: 10),
                _buildEmail(),
                SizedBox(height: 10),
                _buildGender(),
                SizedBox(height: 10),
                _buildCollege(),
                SizedBox(height: 10),
                _buildRollNumber(),
                SizedBox(height: 10),
                _buildPass(),
                SizedBox(height: 10),
                _buildCPass(),
                SizedBox(height: 10),
                _buildButtons()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
