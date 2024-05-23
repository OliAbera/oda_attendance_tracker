import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Generate New Code',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GenerateCodePage(),
    );
  }
}

class GenerateCodePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate New Code'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the registration page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegistrationPage()),
            );
          },
          child: Text('Generate New Code'),
        ),
      ),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late String _class;
  late String _section;
  late DateTime _selectedDate;
  late int _countdownTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _countdownTime = 5; // Default countdown time in minutes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _selectDate(context);
              },
              child: Text('Select Date'),
            ),
            SizedBox(height: 20),
            Text(
              'Selected Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _getLocation();
              },
              child: Text('Get Location'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Countdown Time (minutes):',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                DropdownButton<int>(
                  value: _countdownTime,
                  onChanged: (int? value) {
                    setState(() {
                      _countdownTime = value!;
                    });
                  },
                  items: <int>[1, 2, 3, 4, 5].map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Generate and share the code
                _generateAndShareCode();
              },
              child: Text('Generate and Share'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  // Generate a random 4-digit PIN code based on the current time
  String generateCode() {
    // Use current time as seed for random number generation
    Random random = Random(DateTime.now().millisecondsSinceEpoch);
    int code = random.nextInt(9000) + 1000; // Generate a random number between 1000 and 9999
    return code.toString(); // Convert the code to a string
  }

  // Get the current location and display it
  void _getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Current Location'),
            content: Text('Latitude: ${position.latitude}\nLongitude: ${position.longitude}'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  // Generate and share the code along with the location
  void _generateAndShareCode() async {
    // Generate a new PIN code
    String newCode = generateCode();

    // Get the current location
    Position? position;
    try {
      position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      print('Error getting location: $e');
    }

    // Share the code and location via selected platform (e.g., email)
    _shareCode(newCode, position);
  }

  // Share the generated code and location via selected platform
  void _shareCode(String code, Position? position) async {
    // Show dialog to select sharing platform
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Share Code'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, 'email');
                },
                child: Text('Share via Email'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Add functionality to share via other platforms (e.g., SMS, social media)
                  Navigator.pop(context, 'other');
                },
                child: Text('Share via Other'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Share via Telegram
                  _shareViaTelegram(code, position);
                },
                child: Text('Share via Telegram'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Share via Instagram
                  _shareViaInstagram(code, position);
                },
                child: Text('Share via Instagram'),
              ),
            ],
          ),
        );
      },
    ).then((value) {
      if (value == 'email') {
        _selectSectionAndShareEmail(code);
      } else if (value == 'other') {
        // Implement sharing via other platforms
      }
    });
  }

  // Select section and share PIN code via email
  void _selectSectionAndShareEmail(String code) async {
    // Show dialog to select section
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Section'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, 'A');
                },
                child: Text('Section A'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, 'B');
                },
                child: Text('Section B'),
              ),
              // Add buttons for other sections as needed
            ],
          ),
        );
      },
    ).then((value) {
      if (value != null) {
        _shareCodeWithEmail(code, value);
      }
    });
  }

  // Share PIN code via email to all students in the selected section
  void _shareCodeWithEmail(String code, String section) async {
    // Get student emails based on selected section
    List<String> studentEmails = _getStudentEmailsForSection(section);

    if (studentEmails.isNotEmpty) {
      final String subject = 'Registration PIN Code for Section $section - ${DateFormat('yyyy-MM-dd').format(_selectedDate)}';
      final String body = 'Your PIN Code: $code';

      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: studentEmails.join(','),
        queryParameters: {
          'subject': subject,
          'body': body,
        },
      );

      try {
        await launch(emailLaunchUri.toString());
      } catch (e) {
        print('Error launching email: $e');
      }
    } else {
      // Show a message indicating that no students are found for the selected section
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No students found for Section $section.'),
        ),
      );
    }
  }

  // Get the email addresses of all students in the specified section
  List<String> _getStudentEmailsForSection(String section) {
    // Replace this with your actual logic to fetch student emails based on section
    // For demonstration purposes, I'm just returning some dummy email addresses
    List<String> studentEmails = [];

    switch (section) {
      case 'A':
        studentEmails.addAll([
          'student1.sectionA@gmail.com',
          'student2.sectionA@gmail.com',
          'student3.sectionA@gmail.com',
        ]);
        break;
      case 'B':
        studentEmails.addAll([
          'student1.sectionB@gmail.com',
          'student2.sectionB@gmail.com',
          'student3.sectionB@gmail.com',
        ]);
        break;
      // Add more cases for other sections if needed
    }

    return studentEmails;
  }

  // Share via Telegram
  void _shareViaTelegram(String code, Position? position) async {
    // Define the URL scheme for Telegram
    final String telegramUrl = 'https://t.me/share?url=$code&text=Location: ${position?.latitude}, ${position?.longitude}';

    // Launch Telegram app with the URL
    if (await canLaunch(telegramUrl)) {
      await launch(telegramUrl);
    } else {
      print('Could not launch Telegram.');
    }
  }

  // Share via Instagram
  void _shareViaInstagram(String code, Position? position) async {
    // Define the URL scheme for Instagram
    final String instagramUrl = 'https://www.instagram.com/send?text=Code: $code\nLocation: ${position?.latitude}, ${position?.longitude}';

    // Launch Instagram app with the URL
    if (await canLaunch(instagramUrl)) {
      await launch(instagramUrl);
    } else {
      print('Could not launch Instagram.');
    }
  }
}
