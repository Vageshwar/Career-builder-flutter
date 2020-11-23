import 'dart:io';

import 'package:career_builder/database/db.dart';
import 'package:career_builder/screens/home.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class SkillsForm extends StatefulWidget {
  @override
  _SkillsFormState createState() => _SkillsFormState();
}

class _SkillsFormState extends State<SkillsForm> {
  File _resume;
  bool picked = false;
  String status = "No Files Selected";
  Color color = Colors.red;

  void _uploadResume() {
    DB db = DB();
    if (_resume == null) {
      Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      AlertDialog alert = AlertDialog(
        title: Text("Error"),
        content: Text("Resume Not Selected"),
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
    db.uploadResume(_resume);
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
      return Home();
    }), (route) => false);
    print("uploaded");
  }

  Widget _buildButton() {
    return Column(
      children: [
        IconButton(icon: Icon(Icons.upload_file), onPressed: _pickResume),
        SizedBox(height: 10),
        RaisedButton(
          padding: EdgeInsets.fromLTRB(100, 15, 100, 15),
          color: Colors.blue,
          child: new Text(
            "Upload Resume",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          onPressed: _uploadResume,
        )
      ],
    );
  }

  Widget _buildStatus() {
    return Text(
      status,
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: color),
    );
  }

  void _pickResume() async {
    print("Uploading");
    _resume = await FilePicker.getFile();

    if (_resume != null) {
      print(_resume.path);
      setState(() {
        status = "Resume Selected";
        color = Colors.green;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            _buildStatus(),
            SizedBox(
              height: 10,
            ),
            _buildButton(),
          ],
        ),
      ),
    );
  }
}
