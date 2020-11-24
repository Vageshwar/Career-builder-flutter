import 'dart:io';

import 'package:career_builder/modals/Company.dart';
import 'package:career_builder/modals/academics.dart';
import 'package:career_builder/modals/project.dart';
import 'package:career_builder/modals/student.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DB {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _db = FirebaseFirestore.instance;
  var firebaseStorage = FirebaseStorage.instance.ref();
  Future<bool> loginEmailPassword(String email, String password) async {
    print("Email $email and Password $password");
    try {
      UserCredential userCreds = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = userCreds.user;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future createStudent(String pass, Student student) async {
    var userCred = await firebaseAuth.createUserWithEmailAndPassword(
        email: student.email, password: pass);

    var user = userCred.user;
    if (user != null) {
      addPersonalData(student);
      return true;
    }
  }

  void addPersonalData(Student student) {
    try {
      _db
          .collection("Students")
          .doc(student.email.toLowerCase())
          .collection("Personal")
          .doc(student.email)
          .set({
        "fName": student.fName[0].toUpperCase() + student.fName.substring(1),
        "lName": student.lName[0].toUpperCase() + student.lName.substring(1),
        "email": student.email.toLowerCase(),
        "college": student.college,
        "gender": student.gender,
        "rNo": student.prn,
      });
    } catch (e) {
      print(e);
    }
  }

  void addAcademicsData(Academics ssc, Academics hsc) {
    String email = firebaseAuth.currentUser.email;
    _db
        .collection("Students")
        .doc(email.toLowerCase())
        .collection("Academics")
        .doc(ssc.examName)
        .set({
      "Marks": ssc.marks,
      "Year": ssc.year,
      "University Name": ssc.clgName,
      "Exam Name": ssc.examName
    });

    _db
        .collection("Students")
        .doc(email.toLowerCase())
        .collection("Academics")
        .doc(hsc.examName)
        .set({
      "Marks": hsc.marks,
      "Year": hsc.year,
      "University Name": hsc.clgName,
      "Exam Name": hsc.examName
    });
  }

  void addAcademicsLater(Academics academics) {
    String email = firebaseAuth.currentUser.email;
    _db
        .collection("Students")
        .doc(email.toLowerCase())
        .collection("Academics")
        .doc(academics.examName)
        .set({
      "Marks": academics.marks,
      "Year": academics.year,
      "University Name": academics.clgName,
      "Exam Name": academics.examName
    });
  }

  void addProjectsData(
    Project project,
  ) {
    String email = firebaseAuth.currentUser.email;
    _db
        .collection("Students")
        .doc(email.toLowerCase())
        .collection("Projects")
        .doc(project.title)
        .set({"Title": project.title, "Description": project.description});
  }

  Future addSkillsData() {
    return null;
  }

  void uploadResume(File resume) async {
    String email = firebaseAuth.currentUser.email;
    await firebaseStorage.child(email + "_resume").putFile(resume);
  }

  Future<Student> getStudent() async {
    String email = firebaseAuth.currentUser.email;

    var snapshot = await _db
        .collection("Students")
        .doc(email.toLowerCase())
        .collection("Personal")
        .doc(email)
        .get();
    var data = snapshot.data();
    Student student = Student();
    student.fName = data["fName"];
    student.lName = data["lName"];
    student.gender = data["gender"];
    student.college = data["college"];
    student.email = data["email"];
    student.prn = data["rNo"];

    return student;
  }

  Future<List<Academics>> getAcademics() async {
    print("Acdemics : DB");
    List<Academics> academics = [];
    String email = firebaseAuth.currentUser.email;
    var snapshot1 = await _db
        .collection("Students")
        .doc(email.toLowerCase())
        .collection("Academics")
        .get();
    var data = snapshot1.docs;
    data.forEach((e) {
      Academics ssc = Academics();
      ssc.examName = e.data()["Exam Name"];
      ssc.clgName = e.data()["University Name"];
      ssc.marks = e.data()["Marks"];
      ssc.year = e.data()["Year"];

      academics.add(ssc);
    });
    return academics;
  }

  Future<List<Project>> getProject() async {
    List<Project> projects = [];
    String email = firebaseAuth.currentUser.email;
    var snapshot = await _db
        .collection("Students")
        .doc(email.toLowerCase())
        .collection("Projects")
        .get();

    var data = snapshot.docs;
    data.forEach((e) {
      Project p = Project();
      p.title = e.data()["Title"];
      p.description = e.data()["Description"];
      projects.add(p);
    });

    return projects;
  }

  Future<List<Company>> getCompanies() async {
    List<Company> companies = [];
    String email = firebaseAuth.currentUser.email;
    var snapshot = await _db.collection("Companies").get();
    var data = snapshot.docs;
    data.forEach((e) {
      Company company = Company();
      company.docName = e.id;
      company.name = e.data()["Name"];
      company.desp = e.data()["desp"];
      company.location = e.data()["location"];
      company.e1o = e.data()["e10"];
      company.e12 = e.data()["e12"];
      company.ebe = e.data()["ebe"];
      company.type = e.data()["type"];
      company.positon = e.data()["pos"];
      company.salary = e.data()["salary"];
      companies.add(company);
    });

    return companies;
  }

  void applyfor(Company company) {
    String email = firebaseAuth.currentUser.email;

    _db
        .collection("Students")
        .doc(email.toLowerCase())
        .collection("Applied")
        .doc(company.docName)
        .set({
      "Name": company.name,
      "desp": company.desp,
      "location": company.location,
      "type": company.type,
      "pos": company.positon,
      "e10": company.e1o,
      "e12": company.e12,
      "ebe": company.ebe,
      "salary": company.salary
    });
  }

  void remove(Company company) {
    String email = firebaseAuth.currentUser.email;

    _db
        .collection("Students")
        .doc(email.toLowerCase())
        .collection("Applied")
        .doc(company.docName)
        .delete();
  }

  Future<List<Company>> getMyCompanies() async {
    List<Company> companies = [];
    String email = firebaseAuth.currentUser.email;
    var snapshot = await _db
        .collection("Students")
        .doc(email.toLowerCase())
        .collection("Applied")
        .get();
    var data = snapshot.docs;

    data.forEach((e) {
      Company company = Company();
      company.docName = e.id;
      company.name = e.data()["Name"];
      company.desp = e.data()["desp"];
      company.location = e.data()["location"];
      company.e1o = e.data()["e10"];
      company.e12 = e.data()["e12"];
      company.ebe = e.data()["ebe"];
      company.type = e.data()["type"];
      company.positon = e.data()["pos"];
      company.salary = e.data()["salary"];
      companies.add(company);
    });

    return companies;
  }

  Future<List<Company>> getOnlyCompanies() async {
    List<Company> allcompanies = await getCompanies();
    List<Company> companies = [];
    String email = firebaseAuth.currentUser.email;
    var snapshot = await _db
        .collection("Students")
        .doc(email.toLowerCase())
        .collection("Applied")
        .get();
    var data = snapshot.docs;

    if (data.length == 0) {
      return allcompanies;
    }
    data.forEach((e) {
      Company company = Company();
      company.docName = e.id;
      company.name = e.data()["Name"];
      company.desp = e.data()["desp"];
      company.location = e.data()["location"];
      company.e1o = e.data()["e10"];
      company.e12 = e.data()["e12"];
      company.ebe = e.data()["ebe"];
      company.type = e.data()["type"];
      company.positon = e.data()["pos"];
      company.salary = e.data()["salary"];
      print(allcompanies.contains(company));
      if (allcompanies.contains(company)) {
        allcompanies.remove(company);
        print("Removing " + company.name);
      }
    });

    return allcompanies;
  }

  void deleteProject(String title) {
    String email = firebaseAuth.currentUser.email;
    _db
        .collection("Students")
        .doc(email.toLowerCase())
        .collection("Projects")
        .doc(title)
        .delete();
  }
}
