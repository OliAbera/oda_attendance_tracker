import 'package:flutter/material.dart';// Import the image_picker package
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

// ignore: must_be_immutable
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
        MaterialPageRoute(builder: (context) => QRScanPage()), // Navigate to QRScanPage
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AbsenceCommentPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // Handle menu button pressed
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.location_history),
            onPressed: () {
            },
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
    );
  }
}

class CommentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comment'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // Handle menu button pressed
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notification button pressed
            },
          ),
        ],
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              // Update commentText variable
              // commentText = value;
            },
            decoration: InputDecoration(
              hintText: 'Give your reason here',
            ),
          ),
          DropdownButton<String>(
            // value: selectedSubject,
            onChanged: (String? newValue) {
              // Update selectedSubject variable
              // selectedSubject = newValue!;
            },
            items: <String>[
              'Mathematics',
              'Biology',
              'Chemistry',
              'English',
              'Physics',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle send button pressed
              // print('Comment: $commentText');
              // print('Selected Subject: $selectedSubject');
            },
            child: Text('Send'),
          ),
        ],
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
            
          ],
        ),
      ),
    );
  }
}

class EnterCodePage extends StatefulWidget {
  @override
  _EnterCodePageState createState() => _EnterCodePageState();
}

class _EnterCodePageState extends State<EnterCodePage> {
  late TextEditingController codeController;

  @override
  void initState() {
    super.initState();
    codeController = TextEditingController();
  }

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Code'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: codeController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Enter Code',
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Validate code and show registration status
              String enteredCode = codeController.text;
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Registration Status'),
                  content: Text(enteredCode.isNotEmpty
                      ? 'You are registered!'
                      : 'Please enter a valid code.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            },
            child: Text('Register'),
          ),
        ],
      ),
    );
  }
}
