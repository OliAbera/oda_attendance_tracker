import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location Validation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EnterCodePage(),
    );
  }
}

class EnterCodePage extends StatefulWidget {
  @override
  _EnterCodePageState createState() => _EnterCodePageState();
}

class _EnterCodePageState extends State<EnterCodePage> {
  final _codeController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();
  String? _enteredCode;
  double? _enteredLatitude;
  double? _enteredLongitude;

  void _nextStep() {
    setState(() {
      _enteredCode = _codeController.text;
      _enteredLatitude = double.tryParse(_latitudeController.text);
      _enteredLongitude = double.tryParse(_longitudeController.text);
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ValidateLocationPage(
          code: _enteredCode!,
          latitude: _enteredLatitude!,
          longitude: _enteredLongitude!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Code and Location'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _codeController,
              decoration: InputDecoration(labelText: 'Enter Code'),
            ),
            TextField(
              controller: _latitudeController,
              decoration: InputDecoration(labelText: 'Enter Latitude'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            TextField(
              controller: _longitudeController,
              decoration: InputDecoration(labelText: 'Enter Longitude'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _nextStep,
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

class ValidateLocationPage extends StatefulWidget {
  final String code;
  final double latitude;
  final double longitude;

  ValidateLocationPage({
    required this.code,
    required this.latitude,
    required this.longitude,
  });

  @override
  _ValidateLocationPageState createState() => _ValidateLocationPageState();
}

class _ValidateLocationPageState extends State<ValidateLocationPage> {
  Position? _currentPosition;
  bool _isCodeValid = false;

  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = position;
        _validateCode();
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  void _validateCode() {
    if (_currentPosition != null) {
      double distanceInMeters = Geolocator.distanceBetween(
        widget.latitude,
        widget.longitude,
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );

      setState(() {
        _isCodeValid = distanceInMeters <= 20;
      });
    }
  }

  void _sendApprovalMessage(String platform) async {
    String message = 'Approval Message: Code ${widget.code} is valid.';

    if (platform == 'Gmail') {
      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'recipient@example.com',
        queryParameters: {
          'subject': 'Code Approval',
          'body': message,
        },
      );
      await launch(emailLaunchUri.toString());
    } else if (platform == 'Telegram') {
      final String telegramUrl = 'https://t.me/share/url?url=$message';
      if (await canLaunch(telegramUrl)) {
        await launch(telegramUrl);
      } else {
        print('Could not launch Telegram.');
      }
    } else if (platform == 'Instagram') {
      final String instagramUrl = 'https://www.instagram.com/direct/new/?text=$message';
      if (await canLaunch(instagramUrl)) {
        await launch(instagramUrl);
      } else {
        print('Could not launch Instagram.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Validate Location'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _getCurrentLocation,
                child: Text('Get My Location'),
              ),
              SizedBox(height: 20),
              if (_currentPosition != null)
                Text(
                  'Current Location:\nLatitude: ${_currentPosition!.latitude}, Longitude: ${_currentPosition!.longitude}',
                  textAlign: TextAlign.center,
                ),
              SizedBox(height: 20),
              if (_currentPosition != null)
                Text(
                  _isCodeValid ? 'Code is Valid' : 'Code is Invalid',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: _isCodeValid ? Colors.green : Colors.red,
                  ),
                ),
              if (_isCodeValid)
                Column(
                  children: [
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => _sendApprovalMessage('Telegram'),
                      child: Text('Approve'),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
