import 'package:career_builder/database/db.dart';
import 'package:career_builder/screens/Company.dart';
import 'package:career_builder/screens/appliedCompany.dart';
import 'package:flutter/material.dart';

class Applications extends StatefulWidget {
  @override
  _ApplicationsState createState() => _ApplicationsState();
}

class _ApplicationsState extends State<Applications> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
      child: FutureBuilder(
        future: DB().getMyCompanies(),
        builder: (context, snapshot) {
          if (snapshot.data == null)
            return Center(child: CircularProgressIndicator());
          else if (snapshot.data.length == 0) {
            return Container(
              child: Center(
                child: Text(
                  "No Active Applications",
                  style: TextStyle(color: Colors.black, fontSize: 25),
                ),
              ),
            );
          } else if (snapshot.hasData) {
            return ListView.separated(
                separatorBuilder: (BuildContext context, int i) {
                  return Divider(
                    color: Colors.transparent,
                  );
                },
                padding: EdgeInsets.all(10),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Icon(
                      Icons.badge,
                      color: Colors.white,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                    contentPadding: EdgeInsets.all(10),
                    tileColor: Colors.redAccent,
                    title: Text(
                      snapshot.data[index].name,
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    subtitle: Text(
                      snapshot.data[index].type +
                          " " +
                          snapshot.data[index].positon,
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      AppliedCompany(snapshot.data[index])))
                          .then((value) {
                        setState(() {});
                      });
                    },
                  );
                });
          } else {
            return Container(
              child: Center(
                child: Text(
                  "No Companies are Here!",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
