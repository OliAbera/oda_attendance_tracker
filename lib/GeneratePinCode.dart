import 'package:flutter/material.dart';
import 'dart:math';
import 'package:geolocator/geolocator.dart';
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Navigate to the registration page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegistrationPage()),
                  );
                },
                child: Text('Generate New Code'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the registration page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegistrationPage()),
          );
        },
        tooltip: 'Select Date',
        child: Icon(Icons.calendar_today),
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
  late String _generatedCode;
  late Position _currentPosition;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _generateCode();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Page'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your PIN Code:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    onPressed: () {
                      _showFullScreenDialog(context);
                    },
                    icon: Icon(Icons.zoom_in),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                _generatedCode,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  _getLocation();
                },
                child: Text('Get Location'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _selectDate(context);
        },
        icon: Icon(Icons.calendar_today),
        label: Text('Select Date'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton.icon(
            onPressed: () {
              _shareCode();
            },
            icon: Icon(Icons.share),
            label: Text('Share'),
          ),
        ),
      ),
    );
  }

  // Select a date using date picker
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
        _generateCode(); // Call the function to regenerate the code
      });
    }
  }

  // Generate a random 4-digit PIN code based on the current time
  void _generateCode() {
    // Use current time as seed for random number generation
    Random random = Random(DateTime.now().millisecondsSinceEpoch);
    int code = random.nextInt(9000) + 1000; // Generate a random number between 1000 and 9999
    setState(() {
      _generatedCode = code.toString(); // Convert the code to a string
    });
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

  // Share the generated code and location via Gmail, Telegram, or Instagram
  void _shareCode() {
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
                  _shareViaEmail();
                },
                child: Text('Gmail'),
              ),
              ElevatedButton(
                onPressed: () {
                  _shareViaTelegram();
                },
                child: Text('Telegram'),
              ),
              ElevatedButton(
                onPressed: () {
                  _shareViaInstagram();
                },
                child: Text('Instagram'),
              ),
            ],
          ),
        );
      },
    );
  }

  // Show generated code in full screen dialog
  void _showFullScreenDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Your PIN Code:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  _generatedCode,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Share via Gmail
  void _shareViaEmail() async {
    // Replace this with your email sharing logic
    print('Shared via Gmail');
  }

  // Share via Telegram
  void _shareViaTelegram() async {
    // Replace this with your Telegram sharing logic
    print('Shared via Telegram');
  }

  // Share via Instagram
  void _shareViaInstagram() async {
    // Replace this with your Instagram sharing logic
    print('Shared via Instagram');
  }

  // Get the current location
  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }
}
