import 'package:career_builder/database/db.dart';
import 'package:career_builder/modals/project.dart';
import 'package:career_builder/screens/forms/skills.dart';
import 'package:flutter/material.dart';

class ProjectForm extends StatefulWidget {
  @override
  _ProjectFormState createState() => _ProjectFormState();
}

class _ProjectFormState extends State<ProjectForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Project project;
  String addProject = "Add Project";

  Widget _buildTitle() {
    return Theme(
      data: ThemeData(primaryColor: Colors.blue),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "Title of Project",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(),
          labelText: ("Title"),
        ),
        validator: (String value) {
          // ignore: unrelated_type_equality_checks
          if (value.isEmpty) {
            return 'Title is Required';
          }

          return null;
        },
        onSaved: (value) {
          project.title = value;
        },
      ),
    );
  }

  Widget _buildDesc() {
    return Theme(
      data: ThemeData(primaryColor: Colors.blue),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: null,
        maxLength: 500,
        decoration: InputDecoration(
          hintText: "Description",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(),
          labelText: ("Description"),
        ),
        validator: (String value) {
          // ignore: unrelated_type_equality_checks
          if (value.isEmpty) {
            return 'Please Add Description';
          }

          return null;
        },
        onSaved: (value) {
          project.description = value;
        },
      ),
    );
  }

  void _addProject() {
    project = Project();
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    print("Pressed");
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
                Text("Adding Project")
              ],
            ),
          ),
        );
      },
    );
    DB db = DB();
    db.addProjectsData(project);
    new Future.delayed(new Duration(seconds: 3), () {
      //Navigator.pop(context);
      //rt = true; //pop dialog
      Navigator.pop(context);
      print("After 3 ");
    });
    _formKey.currentState.reset();
    setState(() {
      addProject = "Add Another";
    });
  }

  void _proceed() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return SkillsForm();
    }));
  }

  Widget _buildButtons() {
    return Container(
      child: Column(
        children: [
          new RaisedButton(
            padding: EdgeInsets.fromLTRB(120, 15, 120, 15),
            color: Colors.blue,
            child: new Text(
              addProject,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            onPressed: _addProject,
          ),
          SizedBox(
            height: 10,
          ),
          new RaisedButton(
            padding: EdgeInsets.fromLTRB(132, 15, 132, 15),
            color: Colors.blue,
            child: new Text(
              'Proceed',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            onPressed: _proceed,
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
          "Project Details",
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
                  _buildTitle(),
                  SizedBox(
                    height: 10,
                  ),
                  _buildDesc(),
                  SizedBox(
                    height: 10,
                  ),
                  _buildButtons()
                ],
              ),
            )),
      ),
    );
  }
}
