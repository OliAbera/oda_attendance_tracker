import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 
import 'package:shared_preferences/shared_preferences.dart';// Import the intl package

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: TeacherRoleD(),
    );
  }
}

class TeacherRoleD extends StatefulWidget {
  @override
  _TeacherRoleDState createState() => _TeacherRoleDState();
}

class _TeacherRoleDState extends State<TeacherRoleD>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  int numberOfWeeks = 10;
  bool rotateRight = true;
  int selectedWeek = 1;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _animation = Tween<double>(begin: 0, end: (numberOfWeeks - 1) * 100)
        .animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleSwipe(DragUpdateDetails details) {
    double delta = details.primaryDelta!;
    if (delta > 0) {
      _animationController.reverse();
      rotateRight = false;
    } else if (delta < 0) {
      _animationController.forward();
      rotateRight = true;
    }
  }

  void _selectWeek(int weekNumber) {
    setState(() {
      selectedWeek = weekNumber;
    });
  }

  void _navigateToNextWeek() {
    if (selectedWeek < numberOfWeeks) {
      setState(() {
        selectedWeek++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // Handle menu button press
          },
        ),
        title: Row(
          children: [
            Text('11-D'),
            SizedBox(width: 20), // Add spacing between text and date/week/month/year teller
            // Display the selected week dynamically
            Text('Week $selectedWeek'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Navigate to TeacherRole2.dart when notification icon is pressed
            },
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              // Handle save button press
            },
          ),
          // Add a real-time date teller here
          Text('${DateFormat('MMM dd, yyyy').format(DateTime.now())}'),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          GestureDetector(
            onHorizontalDragUpdate: _handleSwipe,
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(
                      rotateRight ? -_animation.value : _animation.value, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      numberOfWeeks,
                      (index) => WeekButton(
                        weekNumber: index + 1,
                        isSelected: selectedWeek == index + 1,
                        onPressed: () => _selectWeek(index + 1),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                // List of PlayerCard widgets for each student
                PlayerCard(
                  name: 'Abdisa Lema Ideo',
                  photoAsset: 'lib/images/Abdisa.jpg',
                  rollNumber: 1,
                ),
                PlayerCard(
                  name: 'Abdulwehab Nur Bushura',
                  photoAsset: 'assets/images/sterling.jpg',
                  rollNumber: 2,
                ),
                PlayerCard(
                  name: 'Abdurahman Mohamed Garibe',
                  photoAsset: 'lib/images/Abdure.jpg',
                  rollNumber: 3,
                ),
                PlayerCard(
                  name: 'Ararso Fesal Abdulkarim',
                  photoAsset: 'assets/images/foden.jpg',
                  rollNumber: 4,
                ),
                PlayerCard(
                  name: 'Asiya Ahmed Ibrahim',
                  photoAsset: 'assets/images/ederson.jpg',
                  rollNumber: 5,
                ),
                PlayerCard(
                  name: 'Ayantu Abdela Mohammed',
                  photoAsset: 'assets/images/jesus.jpg',
                  rollNumber: 6,
                ),
                PlayerCard(
                  name: 'Ayiti Awel Osman',
                  photoAsset: 'assets/images/laporte.jpg',
                  rollNumber: 7,
                ),
                PlayerCard(
                  name: 'Betelhem Zewude Lema',
                  photoAsset: 'assets/images/rodri.jpg',
                  rollNumber: 8,
                ),
                PlayerCard(
                  name: 'Biladin Rida A/Fita',
                  photoAsset: 'lib/images/Biladin.jpg',
                  rollNumber: 9,
                ),
                PlayerCard(
                  name: 'Calchisa Girma Workina',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 10,
                ),
                PlayerCard(
                  name: 'Ebisa Mokonnen Dibaba',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 11,
                ),
                PlayerCard(
                  name: 'Ebise Imana Seboka',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 12,
                ),
                PlayerCard(
                  name: 'Ebisa Fikadu Lemi',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 13,
                ),
                PlayerCard(
                  name: 'Elsayi Birhanu Tesso',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 14,
                ),
                PlayerCard(
                  name: 'Faya Tafari Jaleta',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 15,
                ),
                PlayerCard(
                  name: 'Feben Nagash Debelu',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 16,
                ),
                PlayerCard(
                  name: 'Fenet Zarihun Oljira',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 17,
                ),
                PlayerCard(
                  name: 'Fininsa Adam Walo',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 18,
                ),
                PlayerCard(
                  name: 'Firaol Dereba Bamo',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 19,
                ),
                PlayerCard(
                  name: 'Firaol Teshome Asafa',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 20,
                ),
                PlayerCard(
                  name: 'Gelgalo Dhugo Hoxesa',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 21,
                ),
                PlayerCard(
                  name: 'Gemechu Fituma Dereje',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 22,
                ),
                PlayerCard(
                  name: 'Guta Marga Bayisa',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 23,
                ),
                PlayerCard(
                name: 'Hana Sintayo Birhanu',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 24,
                ),
                PlayerCard(
                  name: 'Hundaol Abera Kabeta',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 25,
                ),
                PlayerCard(
                  name: 'Husniya M/Dsani A/Simal',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 26,
                ),
                PlayerCard(
                  name: 'Kekeba Hachalu Bekela',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 27,
                ),
                PlayerCard(
                  name: 'Koket Mabratu Melka',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 28,
                ),
                PlayerCard(
                  name: 'Mahammud Jamal Buli',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 29,
                ),
                PlayerCard(
                  name: 'Muaz Zakir Temam',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 30,
                ),
                PlayerCard(
                  name: 'Naboni Abreham Humna',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 31,
                ),
                PlayerCard(
                  name: 'Nagawo Bariso Sage',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 32,
                ),
                PlayerCard(
                  name: 'Naod Getu Zawde',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 33,
                ),
                PlayerCard(
                  name: 'Nura Muzamil Shifa',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 34,
                ),
                PlayerCard(
                  name: 'Obse Tafari Tsegaye',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 35,
                ),
                PlayerCard(
                  name: 'Oluma Abera Seifu',
                  photoAsset: 'lib/images/oli.jpg',
                  rollNumber: 36,
                ),
                PlayerCard(
                  name: 'Ramadan Ganamo Ararso',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 37,
                ),
                PlayerCard(
                  name: 'Robsan Feleke Kasa',
                  photoAsset: 'lib/images/robsi.jpg',
                  rollNumber: 38,
                ),
                PlayerCard(
                  name: 'Sagni Tafesa Abalti',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 39,
                ),
                PlayerCard(
                  name: 'Sifan Girma Tafari',
                  photoAsset: 'assets/images/sifo.jpg',
                  rollNumber: 40,
                ),
                PlayerCard(
                  name: 'Yosef Alemayo Ibsa',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 41,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToNextWeek,
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}

class WeekButton extends StatelessWidget {
  final int weekNumber;
  final bool isSelected;
  final VoidCallback onPressed;

  const WeekButton({
    required this.weekNumber,
    required this.isSelected,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: isSelected
            ? MaterialStateProperty.all<Color>(Colors.blue)
            : MaterialStateProperty.all<Color>(Colors.grey),
      ),
      child: Text('Week $weekNumber'),
    );
  }
}

class PlayerCard extends StatefulWidget {
  final String name;
  final String photoAsset;
  final int rollNumber;

  const PlayerCard({
    required this.name,
    required this.photoAsset,
    required this.rollNumber,
  });

  @override
  _PlayerCardState createState() => _PlayerCardState();
}


class _PlayerCardState extends State<PlayerCard> {
  late SharedPreferences _prefs;
  late List<bool> attendance;
  final String _attendanceKey = 'attendance_${DateTime.now().toString()}';

  @override
  void initState() {
    super.initState();
    _initializeAttendance();
  }

  void _initializeAttendance() async {
    _prefs = await SharedPreferences.getInstance();
    attendance = _prefs.getBoolList(_attendanceKey) ?? List.filled(5, false);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          _showStudentDetailsDialog(context);
        },
        leading: CircleAvatar(
          backgroundImage: AssetImage(widget.photoAsset),
        ),
        title: Text(widget.name),
        subtitle: Text('Roll Number: ${widget.rollNumber}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < 5; i++)
              Checkbox(
                value: attendance[i],
                onChanged: (value) {
                  setState(() {
                    attendance[i] = value!;
                  });
                },
              ),
            SizedBox(width: 10), // Add spacing between checkboxes and icon
            IconButton(
              icon: Icon(Icons.save), // Change icon to save icon
              onPressed: _saveAttendance,
            ),
          ],
        ),
      ),
    );
  }

  void _saveAttendance() {
    _prefs.setBoolList(_attendanceKey, attendance);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Attendance saved successfully')),
    );
  }

  void _showStudentDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Student Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Full Name: ${widget.name}'),
              // Add more details here like age, sex, phone, email, class, section, etc.
              SizedBox(height: 10),
              Text('Attendance Details:'),
              Text('Attended Days: '), // Add actual number of attended days
              Text('Missed Days: '), // Add actual number of missed days
              SizedBox(height: 10),
              LinearProgressIndicator(
                value: 0.7, // Example value, replace with actual progress
              ),
            ],
          ),
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
  }
}
