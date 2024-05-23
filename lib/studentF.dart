import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:oda_attendace_tracker/Scan_QRcode.dart';
import 'enter.dart';
import 'menstruation.dart';

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
      home: HomePage2(),
    );
  }
}

class HomePage2 extends StatelessWidget {
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
              ListTile(
                leading: Icon(Icons.accessibility_new),
                title: Text("See Menstrual Cycle Schedule"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MenstruationApp()),
                  );
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

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("App Theme Settings"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Light'),
                onTap: () {
                  // Handle light theme selection
                  // You can implement theme change logic here
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Dark'),
                onTap: () {
                  // Handle dark theme selection
                  // You can implement theme change logic here
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('System'),
                onTap: () {
                  // Handle system theme selection
                  // You can implement theme change logic here
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              _showCalendarOptions(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              _showSettingsDialog(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Select an option from the bottom navigation bar.'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Enter Code',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scan QR Code',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.comment),
            label: 'Absence Comment',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          _onItemTapped(index, context);
        },
      ),
    );
  }
}

class AbsenceCommentPage extends StatefulWidget {
  @override
  _AbsenceCommentPageState createState() => _AbsenceCommentPageState();
}

class _AbsenceCommentPageState extends State<AbsenceCommentPage> {
  TextEditingController _commentController = TextEditingController();
  Uint8List? _imageBytes;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      if (kIsWeb) {
        var bytes = await pickedFile.readAsBytes();
        setState(() {
          _imageBytes = bytes;
        });
      } else {
        setState(() {
          _imageBytes = File(pickedFile.path).readAsBytesSync();
        });
      }
    }
  }

  Future<void> _sendToTelegram() async {
    final comment = _commentController.text;
    final telegramUrl = 'https://t.me/ODA_attendance/15';

    String textToSend = 'Comment: $comment';
    if (_imageBytes != null) {
      textToSend += '\nImage attached';
    }

    final uri = Uri.parse('$telegramUrl?text=$textToSend');
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch $uri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Absence Comment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                labelText: 'Enter your comment',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            SizedBox(height: 20),
            if (_imageBytes != null)
              kIsWeb
                  ? Image.memory(_imageBytes!)
                  : Image.memory(_imageBytes!),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendToTelegram,
              child: Text('Send'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
