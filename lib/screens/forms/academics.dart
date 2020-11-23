import 'package:career_builder/database/db.dart';
import 'package:career_builder/modals/academics.dart';
import 'package:career_builder/screens/forms/projects.dart';
import 'package:flutter/material.dart';

class AcademicsForm extends StatefulWidget {
  @override
  _AcademicsFormState createState() => _AcademicsFormState();
}

class _AcademicsFormState extends State<AcademicsForm> {
  Academics ssc, hsc;
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

  Widget _buildMarks(bool c) {
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
          if (c)
            ssc.marks = value;
          else
            hsc.marks = value;
        },
      ),
    );
  }

  Widget _buildCollege(bool c) {
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
          if (c) {
            ssc.clgName = value;
          } else
            hsc.clgName = value;
        },
      ),
    );
  }

  Widget _buildYear(bool c) {
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
          if (c) {
            ssc.year = value;
          } else
            hsc.year = value;
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
              'Proceed',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: _submitForm,
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    hsc = Academics();
    hsc.examName = "HSC";
    ssc = Academics();
    ssc.examName = "SSC";
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    print(ssc.clgName + " " + ssc.marks + " " + ssc.year);
    print(hsc.clgName + " " + hsc.marks + " " + hsc.year);
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
    db.addAcademicsData(ssc, hsc);
    new Future.delayed(new Duration(seconds: 3), () {
      //Navigator.pop(context);
      //rt = true; //pop dialog
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return ProjectForm();
      }));
      print("After 3 ");
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
                _buildTitle("10th Details"),
                SizedBox(
                  height: 10,
                ),
                _buildMarks(true),
                SizedBox(
                  height: 10,
                ),
                _buildCollege(true),
                SizedBox(
                  height: 10,
                ),
                _buildYear(true),
                SizedBox(
                  height: 10,
                ),
                _buildTitle("12th/Diploma Details"),
                SizedBox(
                  height: 10,
                ),
                _buildMarks(false),
                SizedBox(
                  height: 10,
                ),
                _buildCollege(false),
                SizedBox(
                  height: 10,
                ),
                _buildYear(false),
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
