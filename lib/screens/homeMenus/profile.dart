import 'package:career_builder/database/db.dart';
import 'package:career_builder/modals/academics.dart';
import 'package:career_builder/modals/project.dart';
import 'package:career_builder/modals/student.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final DB db = DB();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FutureBuilder(
                future: db.getStudent(),
                builder: (context, snapshot) {
                  if (snapshot == null) return CircularProgressIndicator();
                  if (snapshot.hasData) {
                    return PersonalDetials(snapshot.data);
                  } else {
                    return Text("No Data Found");
                  }
                }),
            SizedBox(
              height: 5,
            ),
            Divider(
              color: Colors.red,
              thickness: 2,
            ),
            Text(
              "Academics Details",
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            FutureBuilder(
                future: db.getAcademics(),
                builder: (context, snapshot) {
                  if (snapshot == null) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 2,
                        itemBuilder: (context, i) {
                          return AcademicsDetails(snapshot.data[i]);
                        });
                  } else {
                    return Text("No Data Present");
                  }
                }),
            SizedBox(
              height: 5,
            ),
            Divider(
              color: Colors.red,
              thickness: 2,
            ),
            Text(
              "Projects",
              textAlign: TextAlign.end,
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            FutureBuilder(
                future: db.getProject(),
                builder: (context, snapshot) {
                  if (snapshot == null) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i) {
                          return ProjectsDetails(snapshot.data[i]);
                        });
                  } else {
                    return Text("No Data Present");
                  }
                }),
          ],
        ),
      ),
    );
  }
}

class PersonalDetials extends StatelessWidget {
  final Student student;
  PersonalDetials(this.student);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Personal Details",
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Divider(
              color: Colors.grey,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              student.fName + " " + student.lName,
              style: TextStyle(fontSize: 25, color: Colors.black),
            ),
            Text(student.email,
                style: TextStyle(fontSize: 20, color: Colors.grey)),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: Colors.red,
            ),
            Text("College : " + student.college,
                style: TextStyle(fontSize: 25)),
            Text("Gender: " + student.gender, style: TextStyle(fontSize: 25)),
            Text("Roll Number: " + student.prn, style: TextStyle(fontSize: 25))
          ],
        ),
      ),
    );
  }
}

class AcademicsDetails extends StatelessWidget {
  final Academics academics;
  AcademicsDetails(this.academics);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              academics.examName,
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Divider(
              color: Colors.grey,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Marks " + academics.marks,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Text("College/School " + academics.clgName,
                style: TextStyle(fontSize: 25)),
            Text("Passing Year " + academics.year,
                style: TextStyle(fontSize: 25)),
          ],
        ),
      ),
    );
  }
}

class ProjectsDetails extends StatelessWidget {
  final Project project;
  ProjectsDetails(this.project);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              project.title,
              softWrap: true,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Divider(
              color: Colors.grey,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              project.description,
              softWrap: true,
              style: TextStyle(fontSize: 25, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}