import 'package:career_builder/database/db.dart';
import 'package:career_builder/modals/Company.dart';
import 'package:flutter/material.dart';

class CompanyPage extends StatelessWidget {
  final Company company;
  CompanyPage(this.company);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Card(
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  company.name,
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                Divider(
                  color: Colors.red,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Type and Postion",
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
                Text(
                  company.type + " - " + company.positon,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Location",
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
                Text(
                  company.location,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Salary",
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
                Text(
                  company.salary,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Academics Criteria",
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
                Text(
                  "10th Marks: " +
                      company.e1o +
                      "\n12th Marks: " +
                      company.e12 +
                      "\nEngineering Aggregate: " +
                      company.ebe,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Description",
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
                Text(
                  company.desp,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                    child: Text(
                      "Apply",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    color: Colors.green,
                    padding: EdgeInsets.fromLTRB(120, 10, 120, 10),
                    onPressed: () {
                      DB().applyfor(company);
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Alert"),
                              content: Text("Application Sent"),
                              actions: [
                                FlatButton(
                                  child: Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          });
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
