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
      home: MyHomePage(title: 'Generate New Code'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String generatedCode = '';

  // Generate a random 4-digit code
  String generateCode() {
    Random random = Random();
    int code = random.nextInt(9000) + 1000;
    return code.toString();
  }

  void setGeneratedCode(String code) {
    setState(() {
      generatedCode = code;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.menu), // Replace 'icon_name' with the desired icon
            SizedBox(width: 8),
            Text(widget.title),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('Generate New Code'),
              onPressed: () {
                // Generate a new random code
                String newCode = generateCode();
                setGeneratedCode(newCode);
                // Show the new code in a dialog
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('New Code'),
                    content: Text(newCode),
                    actions: [
                      TextButton(
                        child: Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text('Enter Code'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegistrationPage(
                      generatedCode: generatedCode,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Log out functionality
          // Add your log out logic here
        },
        child: Icon(Icons.logout),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}

class RegistrationPage extends StatefulWidget {
  final String generatedCode;

  RegistrationPage({required this.generatedCode});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late TextEditingController codeController;
  bool isValidCode = false;

  @override
  void initState() {
    super.initState();
    codeController = TextEditingController();
  }

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  void validateCode(String code) {
    setState(() {
      isValidCode = code == widget.generatedCode;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Enter Code:',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 16),
          TextField(
            controller: codeController,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              validateCode(value);
            },
          ),
          SizedBox(height: 16),
          ElevatedButton(
            child: Text('Register'),
            onPressed: isValidCode
                ? () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Registration Status'),
                        content: Text('You are registered!'),
                        actions: [
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  }
                : null,
          ),
        ],
      ),
    );
  }
}