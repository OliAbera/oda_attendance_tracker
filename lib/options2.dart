import 'package:flutter/material.dart';
import 'package:oda_attendace_tracker/Teacher_Role.dart';
import 'package:oda_attendace_tracker/Teacher_RoleA.dart';

import 'package:oda_attendace_tracker/Teacher_RoleB.dart';
import 'package:oda_attendace_tracker/Teacher_RoleC.dart';

// Assuming this contains TeacherRole, TeacherRoleA, TeacherRoleB, and TeacherRoleC

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grade and Section Selection',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GradeSectionSelection(),
    );
  }
}

class GradeSectionSelection extends StatefulWidget {
  @override
  _GradeSectionSelectionState createState() => _GradeSectionSelectionState();
}

class _GradeSectionSelectionState extends State<GradeSectionSelection> {
  String? selectedGrade;
  String? selectedSection;

  void _proceed() {
    if (selectedGrade != null && selectedSection != null) {
      if (selectedGrade == 'Grade 11') {
        if (selectedSection == 'Section A') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TeacherRoleA()),
          );
        } else if (selectedSection == 'Section B') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TeacherRoleB()),
          );
        } else if (selectedSection == 'Section C') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TeacherRoleC()),
          );
        } else if (selectedSection == 'Section D') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TeacherRoleD()),
          );
        } 
      }
    } else {
      // Show a dialog or a snack bar indicating that both grade and section must be selected
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select both grade and section')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grade and Section Selection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ExpansionTile(
              title: Text(selectedGrade ?? 'Select Grade'),
              children: <Widget>[
                ListTile(
                  title: Text('Grade 11'),
                  onTap: () {
                    setState(() {
                      selectedGrade = 'Grade 11';
                    });
                  },
                ),
                ListTile(
                  title: Text('Grade 12'),
                  onTap: () {
                    setState(() {
                      selectedGrade = 'Grade 12';
                    });
                  },
                ),
              ],
            ),
            ExpansionTile(
              title: Text(selectedSection ?? 'Select Section'),
              children: <Widget>[
                ListTile(
                  title: Text('Section A'),
                  onTap: () {
                    setState(() {
                      selectedSection = 'Section A';
                    });
                  },
                ),
                ListTile(
                  title: Text('Section B'),
                  onTap: () {
                    setState(() {
                      selectedSection = 'Section B';
                    });
                  },
                ),
                ListTile(
                  title: Text('Section C'),
                  onTap: () {
                    setState(() {
                      selectedSection = 'Section C';
                    });
                  },
                ),
                ListTile(
                  title: Text('Section D'),
                  onTap: () {
                    setState(() {
                      selectedSection = 'Section D';
                    });
                  },
                ),
              ],
            ),
            ElevatedButton(
              onPressed: _proceed,
              child: Text('Proceed'),
            ),
          ],
        ),
      ),
    );
  }
}