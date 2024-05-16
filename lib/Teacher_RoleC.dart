import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package

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
      home: TeacherRoleC(),
    );
  }
}

class TeacherRoleC extends StatefulWidget {
  @override
  _TeacherRoleCState createState() => _TeacherRoleCState();
}

class _TeacherRoleCState extends State<TeacherRoleC>
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
                  name: 'Abdi Mesfin Chufa',
                  photoAsset: 'lib/images/Abdisa1.jpg',
                  rollNumber: 1,
                ),
                PlayerCard(
                  name: 'Abdulaziz Reshid A/Fita',
                  photoAsset: 'assets/images/sterling.jpg',
                  rollNumber: 2,
                ),
                PlayerCard(
                  name: 'Abdulrashid Haji Sultan',
                  photoAsset: 'lib/images/Abdure1.jpg',
                  rollNumber: 3,
                ),
                PlayerCard(
                  name: 'Abeba Sisay Zonta',
                  photoAsset: 'assets/images/foden.jpg',
                  rollNumber: 4,
                ),
                PlayerCard(
                  name: 'Abenezer Befikadu Gemtessa',
                  photoAsset: 'assets/images/ederson.jpg',
                  rollNumber: 5,
                ),
                PlayerCard(
                  name: 'Adil Befikadu Ararsa',
                  photoAsset: 'assets/images/jesus.jpg',
                  rollNumber: 6,
                ),
                PlayerCard(
                  name: 'Aliyi Irbo Huseno',
                  photoAsset: 'assets/images/laporte.jpg',
                  rollNumber: 7,
                ),
                PlayerCard(
                  name: 'Ansar Mohammed Jemal',
                  photoAsset: 'assets/images/rodri.jpg',
                  rollNumber: 8,
                ),
                PlayerCard(
                  name: 'Dagmawi Teweldebrhan Kifle',
                  photoAsset: 'lib/images/Biladind.jpg',
                  rollNumber: 9,
                ),
                PlayerCard(
                  name: 'Diriba Abdisa Shumi',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 10,
                ),
                PlayerCard(
                  name: 'Dita Alemayehu Imishi',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 11,
                ),
                PlayerCard(
                  name: 'Efrem Addisu Bajira',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 12,
                ),
                PlayerCard(
                  name: 'Eyuel Mamo Abera',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 13,
                ),
                PlayerCard(
                  name: 'Firaol Tsegaye Negash',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 14,
                ),
                PlayerCard(
                  name: 'Fuad Mohammed Amin',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 15,
                ),
                PlayerCard(
                  name: 'Habtamu Diriba Kebeb',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 16,
                ),
                PlayerCard(
                  name: 'Hana Ingida Turuna',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 17,
                ),
                PlayerCard(
                  name: 'Hayat Mohammed Siraj',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 18,
                ),
                PlayerCard(
                  name: 'Hayu Megersa File ',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 19,
                ),
                PlayerCard(
                  name: 'Henok Fikadu Tsegaye',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 20,
                ),
                PlayerCard(
                  name: 'Hermela Adane Tumanso',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 21,
                ),
                PlayerCard(
                  name: 'Ibsa Rameto Bedaso',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 22,
                ),
                PlayerCard(
                  name: 'Jalene Mustefa Gosa',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 23,
                ),
                PlayerCard(
                  name: 'Jitu Sida Megra',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 24,
                ),
                PlayerCard(
                  name: 'Kalid Abajabal Ababoor',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 25,
                ),
                PlayerCard(
                  name: 'Koricho Deyasa Mojo',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 26,
                ),
                PlayerCard(
                  name: 'Mebrat Tashome Dema',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 27,
                ),
                PlayerCard(
                  name: 'Merera Habtamu Bekele',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 28,
                ),
                PlayerCard(
                  name: 'Meti Girma Regasa',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 29,
                ),
                PlayerCard(
                  name: 'Murad Abdurahman Ahmed',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 30,
                ),
                PlayerCard(
                  name: 'Negasa Beshada Mideksa',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 31,
                ),
                PlayerCard(
                  name: 'Ofjan Bonsa Waktola',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 32,
                ),
                PlayerCard(
                  name: 'Oli Silashi Jabessa ',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 33,
                ),
                PlayerCard(
                  name: 'Radia Rida A/Raya',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 34,
                ),
                PlayerCard(
                  name: 'Rekik Fekadu Sime ',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 35,
                ),
                PlayerCard(
                  name: 'Selamawit Mekonnen ',
                  photoAsset: 'lib/images/olik.jpg',
                  rollNumber: 36,
                ),
                PlayerCard(
                  name: 'Sena Fikadu Likisa',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 37,
                ),
                PlayerCard(
                  name: 'Shelemo Dima Gishu',
                  photoAsset: 'lib/images/robsi1.jpg',
                  rollNumber: 38,
                ),
                PlayerCard(
                  name: 'Taju Turi Shubo',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 39,
                ),
                PlayerCard(
                  name: 'Wagane Diriba Seboka',
                  photoAsset: 'assets/images/sifo.jpg',
                  rollNumber: 40,
                ),
                PlayerCard(
                  name: 'Wangari Kasu Mihratu',
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
  List<bool> attendance = List.generate(7, (index) => false); // List to track attendance for each day

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
              onPressed: () {
                // Handle save button press
              },
            ),
          ],
        ),
      ),
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