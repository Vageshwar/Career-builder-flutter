import 'package:career_builder/database/db.dart';
import 'package:career_builder/modals/Company.dart';
import 'package:flutter/material.dart';

class AppliedCompany extends StatefulWidget {
  Company company;
  AppliedCompany(this.company);
  @override
  _AppliedCompanyState createState() => _AppliedCompanyState();
}

class _AppliedCompanyState extends State<AppliedCompany> {
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
                  widget.company.name,
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
                  widget.company.type + " - " + widget.company.positon,
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
                  widget.company.location,
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
                  widget.company.salary,
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
                  widget.company.desp,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                    child: Text(
                      "Withdraw",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    color: Colors.green,
                    padding: EdgeInsets.fromLTRB(80, 10, 80, 10),
                    onPressed: () {
                      DB().remove(widget.company);
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Alert"),
                              content: Text("Removed"),
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
