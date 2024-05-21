import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart'; // Import the url_launcher package

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
      home: TeacherRoleB(),
    );
  }
}

class TeacherRoleB extends StatefulWidget {
  @override
  _TeacherRoleBState createState() => _TeacherRoleBState();
}

class _TeacherRoleBState extends State<TeacherRoleB>
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
        // Trigger a full page refresh
        _selectWeek(selectedWeek);
      });
    }
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Open navigation drawer
              },
            );
          },
        ),
        title: Row(
          children: [
            Text('11-B'),
            SizedBox(width: 20), // Add spacing between text and date/week/month/year teller
            // Display the selected week dynamically
            Text('Week $selectedWeek'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              _launchURL('https://t.me/ODA_attendance/10'); // Launch URL when notification icon is pressed
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
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
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
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                 PlayerCard(
                  name: 'Abdi Abera Jote',
                  photoAsset: 'lib/images/Abdisa1.jpg',
                  rollNumber: 1,
                ),
                PlayerCard(
                  name: 'Abdulselam Hashim Kimo',
                  photoAsset: 'assets/images/sterling.jpg',
                  rollNumber: 2,
                ),
                PlayerCard(
                  name: 'Anane Abera Goshu',
                  photoAsset: 'lib/images/Abdure1.jpg',
                  rollNumber: 3,
                ),
                PlayerCard(
                  name: 'Ararsa Wegi Gidi',
                  photoAsset: 'assets/images/foden.jpg',
                  rollNumber: 4,
                ),
                PlayerCard(
                  name: 'Ayan Nur Bushura',
                  photoAsset: 'assets/images/ederson.jpg',
                  rollNumber: 5,
                ),
                PlayerCard(
                  name: 'Dereje Urgessa Daba',
                  photoAsset: 'assets/images/jesus.jpg',
                  rollNumber: 6,
                ),
                PlayerCard(
                  name: 'Ebisa Husein Hajiya',
                  photoAsset: 'assets/images/laporte.jpg',
                  rollNumber: 7,
                ),
                PlayerCard(
                  name: 'Efrata Melaku Asefa',
                  photoAsset: 'assets/images/rodri.jpg',
                  rollNumber: 8,
                ),
                PlayerCard(
                  name: 'Fenan Shumeta Magarsa ',
                  photoAsset: 'lib/images/Bilading.jpg',
                  rollNumber: 9,
                ),
                PlayerCard(
                  name: 'Feyisa Kanke Wako',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 10,
                ),
                PlayerCard(
                  name: 'Firaol Biruk Diribsa ',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 11,
                ),
                PlayerCard(
                  name: 'Firisa Aman Tufa',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 12,
                ),
                PlayerCard(
                  name: 'Fuad Aliyi Abduraman ',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 13,
                ),
                PlayerCard(
                  name: 'Gelana Amenu Duresa',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 14,
                ),
                PlayerCard(
                  name: 'Gemechis Birhanu Teshoma',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 15,
                ),
                PlayerCard(
                  name: 'Gemechis Jara Deko',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 16,
                ),
                PlayerCard(
                  name: 'Hachalu Hinkosa Tolera ',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 17,
                ),
                PlayerCard(
                  name: 'Hasen Ibrahim Kumbi',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 18,
                ),
                PlayerCard(
                  name: 'Hawan Haile Shifera',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 19,
                ),
                PlayerCard(
                  name: 'Hayidar Abdulhakim Siraj',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 20,
                ),
                PlayerCard(
                  name: 'Hirphasa Wegi Gidi ',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 21,
                ),
                PlayerCard(
                  name: 'Hirut Tefara Supha',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 22,
                ),
                PlayerCard(
                  name: 'Jitu Merga Kanea',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 23,
                ),
                PlayerCard(
                  name: 'Kebeki Desalegn Mulugeta',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 24,
                ),
                PlayerCard(
                  name: 'Kenbon Abata Bache',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 25,
                ),
                PlayerCard(
                  name: 'Lemi Takle Negasa',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 26,
                ),
                PlayerCard(
                  name: 'Meti Gerba Tolera',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 27,
                ),
                PlayerCard(
                  name: 'Muaz Tahir Aliyi',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 28,
                ),
                PlayerCard(
                  name: 'Natnael Buzuna Getahun',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 29,
                ),
                PlayerCard(
                  name: 'Natnael Desalegn Eba',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 30,
                ),
                PlayerCard(
                  name: 'Nayis Lemu Motuma',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 31,
                ),
                PlayerCard(
                  name: 'Obsa Abera Ergabus',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 32,
                ),
                PlayerCard(
                  name: 'Roba Feyisa Adal',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 33,
                ),
                PlayerCard(
                  name: 'Saron Getacho Chala ',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 34,
                ),
                PlayerCard(
                  name: 'Segni Ambe Takele',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 35,
                ),
                PlayerCard(
                  name: 'Sifan Mohammed A/Garo',
                  photoAsset: 'lib/images/olig.jpg',
                  rollNumber: 36,
                ),
                PlayerCard(
                  name: 'Siyane Tadesse Bekele',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 37,
                ),
                PlayerCard(
                  name: 'Sudi Abrar Gelan',
                  photoAsset: 'lib/images/robsi1.jpg',
                  rollNumber: 38,
                ),
                PlayerCard(
                  name: 'Workineh Dinka Ruda ',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 39,
                ),
                PlayerCard(
                  name: 'Zefeni Zenu A/Bor',
                  photoAsset: 'assets/images/sifo.jpg',
                  rollNumber: 40,
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
      drawer: Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: <Widget>[
      DrawerHeader(
        decoration: BoxDecoration(
          color: Colors.purple,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              // Display user's picture (optional)
              backgroundColor: Colors.white,
              radius: 30,
              child: Icon(
                Icons.person,
                size: 40,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'User Name', // Display user's name
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            Text(
              'user@example.com', // Display user's email
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      ListTile(
        leading: Icon(Icons.home),
        title: Text('Home'),
        onTap: () {
          // Navigate to home screen
        },
      ),
      ListTile(
        leading: Icon(Icons.help),
        title: Text('Help Center'),
        onTap: () {
          // Navigate to help center screen
        },
      ),
      ListTile(
        leading: Icon(Icons.question_answer),
        title: Text('FAQ'),
        onTap: () {
          // Navigate to FAQ screen
        },
      ),
      ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text('Exit'),
        onTap: () {
          // Handle exit action
        },
      ),
    ],
  ),
)

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
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple : Colors.grey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          'Week $weekNumber',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class PlayerCard extends StatefulWidget {
  String name;
  final String photoAsset;
  int rollNumber;
  Map<int, bool> _attendance = {
    0: false,
    1: false,
    2: false,
    3: false,
    4: false,
  }; // Map to store attendance state for each day

  PlayerCard({
    required this.name,
    required this.photoAsset,
    required this.rollNumber,
  });

  @override
  _PlayerCardState createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
  late String _editedName;
  late int _editedRollNumber;
  List<String> _dayLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];

  @override
  void initState() {
    super.initState();
    _editedName = widget.name;
    _editedRollNumber = widget.rollNumber;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showStudentDetails(context),
      onLongPress: () => _showEditDialog(),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(widget.photoAsset),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.name),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => _showEditDialog(),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Roll Number: ${widget.rollNumber}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(widget._attendance.length, (index) {
                  return Column(
                    children: [
                      Text(_dayLabels[index]), // Day label
                      Checkbox(
                        value: widget._attendance[index] ?? false,
                        onChanged: (bool? value) {
                          setState(() {
                            widget._attendance[index] = value ?? false;
                          });
                        },
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showStudentDetails(BuildContext context) {
    int attendedDays = widget._attendance.values.where((day) => day).length;
    double attendancePercentage = attendedDays / widget._attendance.length;

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
              Text('Attended Days: $attendedDays out of ${widget._attendance.length}'),
              Text('Attendance Progress: ${(attendancePercentage * 100).toStringAsFixed(2)}%'),
              SizedBox(height: 10),
              LinearProgressIndicator(
                value: attendancePercentage, // Show attendance progress
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

  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Student Information'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  _editedName = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Roll Number'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _editedRollNumber = int.tryParse(value) ?? 0;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Update the student information here
                setState(() {
                  if (_editedName.isNotEmpty) {
                    widget.name = _editedName;
                  }
                  if (_editedRollNumber != 0) {
                    widget.rollNumber = _editedRollNumber;
                  }
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
