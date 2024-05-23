import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oda_attendace_tracker/Enter.dart';
import 'package:oda_attendace_tracker/Scan_QRcode.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Enter Code',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  int _selectedIndex = 0;

  void _onItemTapped(int index, BuildContext context) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EnterCodePage()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => QRScanPage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AbsenceCommentPage()),
      );
    }
  }

  void _showCalendarOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Calendar Options"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.people),
                title: Text("See Class Schedule"),
                onTap: () {
                  Navigator.pop(context);
                  _showSectionSelectionDialog(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSectionSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Section"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text("Section A"),
                onTap: () {
                  Navigator.pop(context);
                  _showScheduleDialog(context, "Section A");
                },
              ),
              ListTile(
                title: Text("Section B"),
                onTap: () {
                  Navigator.pop(context);
                  _showScheduleDialog(context, "Section B");
                },
              ),
              ListTile(
                title: Text("Section C"),
                onTap: () {
                  Navigator.pop(context);
                  _showScheduleDialog(context, "Section C");
                },
              ),
              ListTile(
                title: Text("Section D"),
                onTap: () {
                  Navigator.pop(context);
                  _showScheduleDialog(context, "Section D");
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showScheduleDialog(BuildContext context, String section) {
    Map<String, List<List<String>>> sectionSchedules = {
      "Section A": [
        ["", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"],
        ["1:30 - 2:15", "Physics", "Physics", "Physics", "Agri", "Math"],
        ["2:15 - 3:00", "Biology", "Biology", "English", "Chemistry", "Chemistry"],
        ["3:00 - 3:45", "Chemistry", "Agri", "Chemistry", "Math", "Biology"],
        ["3:45 - 4:15", "Break", "Break", "Break", "Break", "Break"],
        ["4:15 - 5:00", "English", "Math", "Math", "English", "Physics"],
        ["5:00 - 5:45", "Math", "English", "Biology", "Biology", "English"],
        ["5:45 - 6:30", "Agri", "Chemistry", "---", "Physics", "---"],
      ],
      "Section B": [
         ["", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"],
        ["1:30 - 2:15", "English", "Chemistry", "Biology", "Chemistry", "English"],
        ["2:15 - 3:00", "Physics", "English", "Agri", "English", "Math"],
        ["3:00 - 3:45", "Math", "Biology", "Physics", "Biology", "Physics"],
        ["3:45 - 4:15", "Break", "Break", "Break", "Break", "Break"],
        ["4:15 - 5:00", "Agri", "Physics", "English", "Math", "Biology"],
        ["5:00 - 5:45", "Chemistry", "Math", "Chemistry", "Physics", "Chemistry"],
        ["5:45 - 6:30", "Biology", "---", "Math", "Agri", "---"],
      ],
      "Section C": [
       ["", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"],
        ["1:30 - 2:15", "Chemistry", "English", "Chemistry", "Biology", "Biology"],
        ["2:15 - 3:00", "Agri", "Physics", "Math", "Physics", "Agri"],
        ["3:00 - 3:45", "Physics", "Math", "Agri", "English", "Math"],
        ["3:45 - 4:15", "Break", "Break", "Break", "Break", "Break"],
        ["4:15 - 5:00", "Biology", "Chemistry", "Physics", "Chemistry", "English"],
        ["5:00 - 5:45", "English", "Biology", "English", "Math", "Physics"],
        ["5:45 - 6:30", "Math", "---", "Biology", "---", "Chemistry"],
      ],
      "Section D": [
       ["", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"],
        ["1:30 - 2:15", "Math", "Math", "English", "Math", "Physics"],
        ["2:15 - 3:00", "English", "Chemistry", "Physics", "Biology", "English"],
        ["3:00 - 3:45", "Biology", "English", "Biology", "Agri", "Chemistry"],
        ["3:45 - 4:15", "Break", "Break", "Break", "Break", "Break"],
        ["4:15 - 5:00", "Chemistry", "Biology", "Chemistry", "Physics", "Agri"],
        ["5:00 - 5:45", "Agri", "Physics", "Math", "English", "Math"],
        ["5:45 - 6:30", "Physics", "---", "---", "Chemistry", "Biology"],
      ],
    };

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Class Schedule - $section"),
          content: SingleChildScrollView(
            child: DataTable(
              columns: [
                for (var day in sectionSchedules[section]!.first)
                  DataColumn(label: Text(day)),
              ],
              rows: [
                for (int i = 1; i < sectionSchedules[section]!.length; i++)
                  DataRow(cells: [
                    for (var cell in sectionSchedules[section]![i])
                      DataCell(Text(cell)),
                  ]),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.location_history),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Text('Home Page Content'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dialpad),
            label: 'Enter Code',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.scanner),
            label: 'Scan QR Code',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Comment',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: (index) => _onItemTapped(index, context),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCalendarOptions(context);
        },
        child: Icon(Icons.calendar_today),
      ),
    );
  }
}
class AbsenceCommentPage extends StatefulWidget {
  @override
  _AbsenceCommentPageState createState() => _AbsenceCommentPageState();
}

class _AbsenceCommentPageState extends State<AbsenceCommentPage> {
  late TextEditingController _commentController;
  File? _image;

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Absent Comment'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Explain your absence:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _commentController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Type your comment here...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle send button pressed
                  },
                  child: Text('Send'),
                ),
                SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  icon: Icon(Icons.photo),
                  label: Text('Pick Image'),
                ),
                SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.camera),
                  icon: Icon(Icons.camera),
                  label: Text('Take Picture'),
                ),
              ],
            ),
            SizedBox(height: 20),
            _image != null
                ? Image.file(
                    _image!,
                    height: 200,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
