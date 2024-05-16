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
      home: TeacherRoleA(),
    );
  }
}

class TeacherRoleA extends StatefulWidget {
  @override
  _TeacherRoleAState createState() => _TeacherRoleAState();
}

class _TeacherRoleAState extends State<TeacherRoleA>
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
                  name: 'Abdi Sultan Lemu',
                  photoAsset: 'lib/images/Abdisa1.jpg',
                  rollNumber: 1,
                ),
                PlayerCard(
                 name: 'Abdulfeta Abdulahi Hasen',
                  photoAsset: 'assets/images/sterling.jpg',
                  rollNumber: 2,
                ),
                PlayerCard(
                  name: 'Abduraman Husein Beriso',
                  photoAsset: 'lib/images/Abdure1.jpg',
                  rollNumber: 3,
                ),
                PlayerCard(
                  name: 'Adil Abde Dali',
                  photoAsset: 'assets/images/foden.jpg',
                  rollNumber: 4,
                ),
                PlayerCard(
                  name: 'Barnaf Tariku Humnesa',
                  photoAsset: 'assets/images/ederson.jpg',
                  rollNumber: 5,
                ),
                PlayerCard(
                  name: 'Bereket Dasta Tiroro',
                  photoAsset: 'assets/images/jesus.jpg',
                  rollNumber: 6,
                ),
                PlayerCard(
                  name: 'Bilise Birhanu Degaga',
                  photoAsset: 'assets/images/laporte.jpg',
                  rollNumber: 7,
                ),
                PlayerCard(
                  name: 'Bona Abdisa Ebisa',
                  photoAsset: 'assets/images/rodri.jpg',
                  rollNumber: 8,
                ),
                PlayerCard(
                  name: 'Dame Tilahun Abera',
                  photoAsset: 'lib/images/Biladinh.jpg',
                  rollNumber: 9,
                ),
                PlayerCard(
                  name: 'Dawit Shibiru Olcha',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 10,
                ),
                PlayerCard(
                  name: 'Dawit Tariku Haile',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 11,
                ),
                PlayerCard(
                  name: 'Eba Hachalu Bekele',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 12,
                ),
                PlayerCard(
                  name: 'Ebrahim Mohammed Seid',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 13,
                ),
                PlayerCard(
                  name: 'Eyosiyas Semu Bogale',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 14,
                ),
                PlayerCard(
                  name: 'Fenet Beshada Jima',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 15,
                ),
                PlayerCard(
                  name: 'Fenet Damena Alemu',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 16,
                ),
                PlayerCard(
                  name: 'Foziya Mohammed Logomo',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 17,
                ),
                PlayerCard(
                  name: 'Gatepi Bereket T/Mariam',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 18,
                ),
                PlayerCard(
                  name: 'Girma Tolera Kebede',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 19,
                ),
                PlayerCard(
                  name: 'Habtamu Girma Dinsa ',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 20,
                ),
                PlayerCard(
                  name: 'Hana Tsagate Gugsa',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 21,
                ),
                PlayerCard(
                  name: 'Hawinan Dasta Egato',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 22,
                ),
                PlayerCard(
                  name: 'Jemal Aliyi Abdule',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 23,
                ),
                PlayerCard(
                   name: 'Kenenisa Tamena Abdisa',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 24,
                ),
                PlayerCard(
                  name: 'Megersa Shumi Leliso',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 25,
                ),
                PlayerCard(
                  name: 'Mekdes Belay Silashi',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 26,
                ),
                PlayerCard(
                  name: 'Meron Hayile Dinagde',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 27,
                ),
                PlayerCard(
                  name: 'Meti Sultan Ali',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 28,
                ),
                PlayerCard(
                  name: 'Moti Shimallis Gizacho',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 29,
                ),
                PlayerCard(
                  name: 'Nebil Tijani A/Mecha',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 30,
                ),
                PlayerCard(
                  name: 'Olbirat Charu Disasa',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 31,
                ),
                PlayerCard(
                  name: 'Rebuma Sisay Cibsa',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 32,
                ),
                PlayerCard(
                  name: 'Robsan Yonas Bayisa',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 33,
                ),
                PlayerCard(
                  name: 'Samuel Tolera Nada',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 34,
                ),
                PlayerCard(
                  name: 'Segni Siyoum Nagasa',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 35,
                ),
                PlayerCard(
                  name: 'Selam Beharu Kerga',
                  photoAsset: 'lib/images/olig.jpg',
                  rollNumber: 36,
                ),
                PlayerCard(
                  name: 'Sena Gonfa Worku ',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 37,
                ),
                PlayerCard(
                  name: 'Sifan Hayilu Adugna',
                  photoAsset: 'lib/images/robsi1.jpg',
                  rollNumber: 38,
                ),
                PlayerCard(
                  name: 'Wabi Hirpha Raggasa',
                  photoAsset: 'assets/images/torres.jpg',
                  rollNumber: 39,
                ),
                PlayerCard(
                  name: 'Waktola Gobana Dento',
                  photoAsset: 'assets/images/sifo.jpg',
                  rollNumber: 40,
                ),
                PlayerCard(
                  name: 'Yeabsira Mesih Kinfe',
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