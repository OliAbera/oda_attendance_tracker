import 'dart:async';
import 'package:flutter/material.dart';
import 'package:oda_attendace_tracker/Welcomescreen.dart';
import 'package:oda_attendace_tracker/WelcomescreenS.dart';
import 'package:oda_attendace_tracker/WelcomescreenT.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ODA-Attend',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/onboarding': (context) => OnboardingScreen(),
        '/roleSelection': (context) => RoleSelectionPage(),
        '/welcomeScreen': (context) => WelcomeScreen(),
        '/teacherRole': (context) => TeacherRole(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/onboarding'); // Navigate to OnboardingScreen
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 24, 2, 77), Color.fromRGBO(155, 4, 185, 1)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/images/LOGO.png',
                width: 150,
              ),
              SizedBox(height: 20),
              Text(
                'ODA-Attend',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoleSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Your Role'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          _buildRoleButton(context, 'Teacher', 'teacher.png'),
          SizedBox(height: 20),
          _buildRoleButton(context, 'Student', 'student.png'),
          SizedBox(height: 20),
          _buildRoleButton(context, 'Admin', 'admin.png'),
        ],
      ),
    );
  }

  Widget _buildRoleButton(BuildContext context, String role, String imageName) {
    final buttonWidth = 150.0; // Fixed width for the button
    return SizedBox(
      width: buttonWidth,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey, // Gray color
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ElevatedButton(
          onPressed: () {
            if (role == 'Teacher') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WelcomeScreenT()),
              );
            } else if (role == 'Student') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WelcomeScreenS()),
              );
            } else if (role == 'Admin') {
              Navigator.pushNamed(context, '/welcomeScreen'); // Navigate to WelcomeScreen
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            elevation: 0,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: Column(
            children: [
              Image.asset(
                'lib/images/$imageName',
                width: 100,
              ),
              SizedBox(height: 8),
              Text(
                role,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TeacherRole extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Placeholder for Teacher Role Screen
    return Container(
      color: Colors.white,
      child: Center(
        child: Text(
          'Teacher Role Screen Placeholder',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    OnboardPage(
      image: 'lib/images/QR_phone.png',
      title: 'QR Code Attendance',
      description:
          'Easily take attendance by displaying a QR code for students to scan.',
    ),
    OnboardPage(
      image: 'lib/images/code_enter.png',
      title: 'Randomized Code System',
      description:
          'Attendance is recorded using a secure randomized code system.',
    ),
    OnboardPage(
      image: 'lib/images/map.png',
      title: 'Geolocation Tracking',
      description:
          'Track attendance based on students\' locations for accuracy.',
    ),
    OnboardPage(
      image: 'lib/images/graph.png',
      title: 'Attendance Presentation',
      description:
          'Visualize attendance data with graphs and pie charts for better analysis.',
    ),
    OnboardPage(
      image: 'lib/images/security.png',
      title: 'Secured System',
      description:
          'Ensure the security of attendance data with robust encryption.',
    ),
    OnboardPage(
      image: 'lib/images/done_icon.png',
      title: 'Easy to Use',
      description:
          'Simplify attendance tracking for teachers and administrators.',
    ),
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pages[_currentIndex],
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      if (_currentIndex < _pages.length - 1) {
                        setState(() {
                          _currentIndex++;
                        });
                      } else {
                        Navigator.pushReplacementNamed(context, '/roleSelection'); // Navigate to RoleSelectionPage
                      }
                    },
                    child: Text(
                      _currentIndex == _pages.length - 1 ? 'Finish' : 'Next',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/roleSelection'); // Navigate to RoleSelectionPage
                },
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const OnboardPage({
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Image.asset(
            image,
            fit: BoxFit.cover, // Ensure the image covers the entire space
          ),
        ),
        SizedBox(height: 30),
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center, // Center the title text
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}