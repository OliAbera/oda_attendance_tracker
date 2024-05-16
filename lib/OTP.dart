import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OTP Verification',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => OTPScreen(),
        '/math_otp': (context) => MathOTP(),
        // Add routes for other OTP pages
      },
    );
  }
}

class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _otpController = TextEditingController();

  void _navigateToPage(BuildContext context, String page) {
    Navigator.pushNamed(context, page);
  }

  void _validateOTP(String otp) {
    switch (otp) {
      case '015567':
        _navigateToPage(context, '/math_otp');
        break;
      // Add cases for other OTP codes
      default:
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Invalid OTP'),
            content: Text('Please enter a valid OTP.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
    }
  }

  void _handleNextButtonPressed() {
    String enteredOTP = _otpController.text;
    _validateOTP(enteredOTP);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter OTP'),
      ),
      body: Column(
        children: [
          // Picture at the top with customization
          Container(
            height: MediaQuery.of(context).size.height * 0.5, // Fullscreen
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/images/security.png'), // Replace 'picture.jpg' with your image path
                fit: BoxFit.cover,
                alignment: Alignment.center,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.6), // Add some opacity to darken the image
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          // Spacer
          SizedBox(height: 20.0),
          // Beautiful Box for OTP Input
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    maxLength: 6, // assuming OTP is of length 6
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter OTP',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _handleNextButtonPressed,
                  child: Text('Next'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class MathOTP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Math OTP'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Picture at the top
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/images/math_image.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome message
                Text(
                  'Welcome, Teacher!',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                // Date and time
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Row(
                      children: [
                        Icon(Icons.access_time),
                        SizedBox(width: 5.0),
                        Text(
                          'Start Time: 08:00 AM',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(width: 20.0),
                        Icon(Icons.access_time),
                        SizedBox(width: 5.0),
                        Text(
                          'End Time: 10:00 AM',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                // Buttons to start and end class
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Start class logic
                      },
                      child: Text('Start'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // End class logic
                      },
                      child: Text('End'),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                // Students list
                Text(
                  'Students:',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10, // Change this to the actual number of students
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('Student ${index + 1}'),
                        subtitle: Text('Class: 10, Section: A'),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Start Time: 08:00 AM'),
                            Text('End Time: 09:00 AM'),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}