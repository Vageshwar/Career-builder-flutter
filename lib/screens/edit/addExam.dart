import 'package:career_builder/database/db.dart';
import 'package:career_builder/modals/academics.dart';
import 'package:career_builder/screens/forms/projects.dart';
import 'package:career_builder/screens/home.dart';
import 'package:flutter/material.dart';

class AddAcademicsForm extends StatefulWidget {
  @override
  _AddAcademicsFormState createState() => _AddAcademicsFormState();
}

class _AddAcademicsFormState extends State<AddAcademicsForm> {
  Academics academics;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.black,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildMarks() {
    return Theme(
      data: ThemeData(primaryColor: Colors.blue),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: "Marks",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.notes),
          labelText: ("Marks"),
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
          academics.marks = value;
        },
      ),
    );
  }

  Widget _buildCollege() {
    return Theme(
      data: ThemeData(primaryColor: Colors.blue),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "University Name",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.school),
          labelText: ("University Name"),
        ),
        validator: (String value) {
          // ignore: unrelated_type_equality_checks
          if (value.isEmpty) {
            return 'This is Required';
          }
          // RegExp re = new RegExp(r'/^[A-Za-z]+$/');
          // if (!re.hasMatch(value)) return "Please Enter Alphabets";

          return null;
        },
        onSaved: (value) {
          academics.clgName = value;
        },
      ),
    );
  }

  Widget _buildExamName() {
    return Theme(
      data: ThemeData(primaryColor: Colors.blue),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "Degree Name",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.school),
          labelText: ("Degree"),
        ),
        validator: (String value) {
          // ignore: unrelated_type_equality_checks
          if (value.isEmpty) {
            return 'This is Required';
          }
          // RegExp re = new RegExp(r'/^[A-Za-z]+$/');
          // if (!re.hasMatch(value)) return "Please Enter Alphabets";

          return null;
        },
        onSaved: (value) {
          academics.examName = value;
        },
      ),
    );
  }

  Widget _buildYear() {
    return Theme(
      data: ThemeData(primaryColor: Colors.blue),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "Year of Passing",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.school),
          labelText: ("Year of Passing"),
        ),
        validator: (String value) {
          // ignore: unrelated_type_equality_checks
          if (value.isEmpty) {
            return 'This is required';
          }
          RegExp re = new RegExp(r'^\d*\.?\d*$');
          if (!re.hasMatch(value)) return "Please Enter Numerics";
          // RegExp re = new RegExp(r'/^[A-Za-z]+$/');
          // if (!re.hasMatch(value)) return "Please Enter Alphabets";

          return null;
        },
        onSaved: (value) {
          academics.year = value;
        },
      ),
    );
  }

  Widget _buildButtons() {
    return Container(
      child: Column(
        children: [
          new RaisedButton(
            padding: EdgeInsets.fromLTRB(145, 15, 145, 15),
            color: Colors.blue,
            child: new Text(
              'Add',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: _submitForm,
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    academics = Academics();
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    DB db = DB();
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
    db.addAcademicsLater(academics);
    new Future.delayed(new Duration(seconds: 2), () {
      //Navigator.pop(context);
      //rt = true; //pop dialog
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return Home();
      }), (route) => false);
      print("After 2 ");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add Academics Details",
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
                SizedBox(
                  height: 50,
                ),
                _buildExamName(),
                SizedBox(
                  height: 10,
                ),
                _buildMarks(),
                SizedBox(
                  height: 10,
                ),
                _buildCollege(),
                SizedBox(
                  height: 10,
                ),
                _buildYear(),
                SizedBox(
                  height: 10,
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
