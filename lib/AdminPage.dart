import 'package:flutter/material.dart';
import 'package:oda_attendace_tracker/Add_student.dart';
import 'package:oda_attendace_tracker/Add_teacher.dart';
import 'package:oda_attendace_tracker/VSTBottompage.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: AdminScreen(),
    );
  }
}

class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 250,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Image.asset(
                'lib/images/admin.png', // Replace with your image path
                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddTeacher1Page()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  icon: Icon(
                    Icons.person_add,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Add Teacher',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddTeacher2Page()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  icon: Icon(
                    Icons.person_add,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Add Student',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BottomNavBarDemo()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              icon: Icon(
                Icons.bar_chart_outlined,
                color: Colors.white,
              ),
              label: Text(
                'Analysis',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class AddTeacherPage extends StatefulWidget {
  @override
  _AddTeacherPageState createState() => _AddTeacherPageState();
}

class _AddTeacherPageState extends State<AddTeacherPage> {
  List<TeacherInfo> addedTeachers = [];
  List<TeacherInfo> removedTeachers = [];
  String teacherName = '';
  String teacherSubject = '';
  String teacherSection = '';

  void addTeacher() {
    if (teacherName.isNotEmpty && teacherSubject.isNotEmpty && teacherSection.isNotEmpty) {
      setState(() {
        addedTeachers.add(TeacherInfo(
          name: teacherName,
          subject: teacherSubject,
          section: teacherSection,
          time: DateTime.now(),
        ));
        teacherName = '';
        teacherSubject = '';
        teacherSection = '';
      });
    }
  }

  void removeTeacher(String teacher) {
    setState(() {
      addedTeachers.removeWhere((info) => info.name == teacher);
      removedTeachers.add(addedTeachers.firstWhere((info) => info.name == teacher));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add/Remove Teacher'),
        actions: [
          IconButton(
            icon: Icon(Icons.visibility),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TeacherListPage(addedTeachers, removedTeachers)),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name:',
              style: TextStyle(fontSize: 16),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter teacher name',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  teacherName = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'Subject:',
              style: TextStyle(fontSize: 16),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter teacher subject',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  teacherSubject = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'Section:',
              style: TextStyle(fontSize: 16),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter teacher section',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  teacherSection = value;
                });
              },
            ),
            SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: addTeacher,
                  child: Text('Add Teacher'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (teacherName.isNotEmpty) {
                      removeTeacher(teacherName);
                    }
                  },
                  child: Text('Remove Teacher'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AddStudentPage extends StatefulWidget {
  @override
  _AddStudentPageState createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  List<StudentInfo> addedStudents = [];
  List<StudentInfo> removedStudents = [];
  String studentName = '';
  String studentGrade = '';
  String studentSection = '';

  void addStudent() {
    if (studentName.isNotEmpty && studentGrade.isNotEmpty && studentSection.isNotEmpty) {
      setState(() {
        addedStudents.add(StudentInfo(
          name: studentName,
          grade: studentGrade,
          section: studentSection,
          time: DateTime.now(),
        ));
        studentName = '';
        studentGrade = '';
        studentSection = '';
      });
    }
  }

  void removeStudent(String student) {
    setState(() {
      addedStudents.removeWhere((info) => info.name == student);
      removedStudents.add(addedStudents.firstWhere((info) => info.name == student));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add/Remove Student'),
        actions: [
          IconButton(
            icon: Icon(Icons.visibility),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StudentListPage(addedStudents, removedStudents)),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name:',
              style: TextStyle(fontSize: 16),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter student name',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  studentName = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'Grade:',
              style: TextStyle(fontSize: 16),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter student grade',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  studentGrade = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'Section:',
              style: TextStyle(fontSize: 16),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter student section',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  studentSection = value;
                });
              },
            ),
            SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: addStudent,
                  child: Text('Add Student'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (studentName.isNotEmpty) {
                      removeStudent(studentName);
                    }
                  },
                  child: Text('Remove Student'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StudentListPage extends StatelessWidget {
  final List<StudentInfo> addedStudents;
  final List<StudentInfo> removedStudents;

  StudentListPage(this.addedStudents, this.removedStudents);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student List'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Added Students:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: addedStudents.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    '${addedStudents[index].name} - ${addedStudents[index].grade} - ${addedStudents[index].section} - ${addedStudents[index].time.toString()}',
                    style: TextStyle(color: Colors.green), // Added students displayed in green
                  ),
                );
              },
            ),
            SizedBox(height: 16.0),
           
            SizedBox(height: 8.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: removedStudents.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    '${removedStudents[index].name} - ${removedStudents[index].grade} - ${removedStudents[index].section} - ${removedStudents[index].time.toString()}',
                    style: TextStyle(color: Colors.red), // Removed students displayed in red
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TeacherListPage extends StatelessWidget {
  final List<TeacherInfo> addedTeachers;
  final List<TeacherInfo> removedTeachers;

  TeacherListPage(this.addedTeachers, this.removedTeachers);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher List'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Added Teachers:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: addedTeachers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    '${addedTeachers[index].name} - ${addedTeachers[index].subject} - ${addedTeachers[index].section} - ${addedTeachers[index].time.toString()}',
                    style: TextStyle(color: Colors.green), // Added teachers displayed in green
                  ),
                );
              },
            ),
            SizedBox(height: 16.0),
            
            SizedBox(height: 8.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: removedTeachers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    '${removedTeachers[index].name} - ${removedTeachers[index].subject} - ${removedTeachers[index].section} - ${removedTeachers[index].time.toString()}',
                    style: TextStyle(color: Colors.red), // Removed teachers displayed in red
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class StudentInfo {
  final String name;
  final String grade;
  final String section;
  final DateTime time;

  StudentInfo({required this.name, required this.grade, required this.section, required this.time});
}

class TeacherInfo {
  final String name;
  final String subject;
  final String section;
  final DateTime time;

  TeacherInfo({required this.name, required this.subject, required this.section, required this.time});
}