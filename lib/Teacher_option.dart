import 'package:flutter/material.dart';
import 'package:oda_attendace_tracker/GeneratePinCode.dart';
import 'package:oda_attendace_tracker/barcode.dart';
import 'package:oda_attendace_tracker/optionchart.dart';

import 'package:oda_attendace_tracker/options2.dart';// Import Option2.dart

void main() {
  runApp(MaterialApp(
    home: TeacherOptionsPage(),
  ));
}

class TeacherOptionsPage extends StatefulWidget {
  @override
  _TeacherOptionsPageState createState() => _TeacherOptionsPageState();
}

class _TeacherOptionsPageState extends State<TeacherOptionsPage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    TeacherRolePage(),
    GenerateQRPage(),
    CreateSessionPage(), // Changed to CreateSessionPage for "Give Session"
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (_selectedIndex == 0) {
      // Navigate to Option2.dart when "Take attendance" is selected
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GradeSectionSelection()),
      );
    } else if (_selectedIndex == 2) {
      // Navigate to OTPScreen when "Give a Session" is selected
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BottomNavBarDemo1()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher Options'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 27, 2, 85),
                Color.fromARGB(244, 124, 3, 104),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        automaticallyImplyLeading: _selectedIndex != 0,
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.white, // Set scaffold background color to white
          ),
          Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Take Attendance Manually',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'Generate QR Code',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: 'Generate chart',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class GenerateQRPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            onPressed: () {
              // Navigate to the code_pin.dart file
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QRCodeGenerator()),
              );
            },
            icon: Icon(Icons.qr_code),
            label: Text('Generate QR-code'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(20),
              textStyle: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              // Navigate to the QR code generator page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GenerateCodePage()),
              );
            },
            icon: Icon(Icons.numbers),
            label: Text('Generate pin-code'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(20),
              textStyle: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}

class TeacherRolePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Hide back arrow
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 248, 245, 248),
                Color.fromRGBO(239, 240, 241, 1),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.white, // Set scaffold background color to white
        child: Center(
          child: Text('Take Attendance Page'),
        ),
      ),
    );
  }
}

class CodePinPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate QR-code'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 241, 241, 241),
                Color.fromARGB(255, 247, 249, 250),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: Center(
        child: Text('Code Pin Generation Page'),
      ),
    );
  }
}

class CreateSessionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Hide back arrow
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 246, 245, 247),
                const Color.fromARGB(255, 243, 244, 245),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Logic to create a session
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BottomNavBarDemo1()),
            );
          },
          child: Text('Generate chart'),
        ),
      ),
    );
  }
}