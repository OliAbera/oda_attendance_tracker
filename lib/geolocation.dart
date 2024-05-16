import 'package:flutter/material.dart';
import 'dart:math';

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
            // Generate a new PIN code and navigate to registration page
            String newCode = generateCode();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RegistrationPage(generatedCode: newCode),
              ),
            );
          },
          child: Text('Generate New Code'),
        ),
      ),
    );
  }

  // Generate a random 4-digit PIN code
  String generateCode() {
    Random random = Random();
    int code = random.nextInt(9000) + 1000; // Generate a random number between 1000 and 9999
    return code.toString(); // Convert the code to a string
  }
}

class RegistrationPage extends StatelessWidget {
  final String generatedCode;

  RegistrationPage({required this.generatedCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Page'),
      ),
      body: Center(
        child: Text(
          'Generated PIN Code: $generatedCode',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}