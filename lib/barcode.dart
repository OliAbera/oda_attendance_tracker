import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class QRCodeGenerator extends StatefulWidget {
  const QRCodeGenerator({Key? key}) : super(key: key);

  @override
  _QRCodeGeneratorState createState() => _QRCodeGeneratorState();
}

class _QRCodeGeneratorState extends State<QRCodeGenerator> {
  late String _inputValue;
  late TextEditingController _textEditingController;
  late DateTime _selectedDate;
  Map<String, bool?> _selectedSections = {
    'Section A': false,
    'Section B': false,
    'Section C': false,
    'Section D': false,
  };

  @override
  void initState() {
    super.initState();
    _inputValue = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _textEditingController = TextEditingController(text: _inputValue);
    _selectedDate = DateTime.now();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Generator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildQRCodeGenerator(),
      ),
    );
  }

  Widget _buildQRCodeGenerator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {
            _selectDate(context);
          },
          child: Text('Select Date'),
        ),
        SizedBox(height: 20),
        Text(
          'Selected Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            _generateQRCode();
          },
          child: Text('Generate QR Code'),
        ),
        SizedBox(height: 20),
        Expanded(
          child: Center(
            child: SizedBox(
              height: 300,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: SfBarcodeGenerator(
                  value: DateFormat('yyyy-MM-dd').format(_selectedDate),
                  textAlign: TextAlign.justify,
                  textSpacing: 10,
                  symbology: QRCode(
                    inputMode: QRInputMode.alphaNumeric,
                    codeVersion: QRCodeVersion.auto,
                    errorCorrectionLevel: ErrorCorrectionLevel.quartile,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            _showSectionSelectionDialog();
          },
          child: Text('Share QR Code via Email'),
        ),
        SizedBox(height: 20),
        Text('Selected Sections: $_selectedSections'),
      ],
    );
  }

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
        _inputValue = DateFormat('yyyy-MM-dd').format(_selectedDate);
        _textEditingController.text = _inputValue;
      });
    }
  }

  void _generateQRCode() {
    // Your logic to generate QR code based on selected date
    // You can implement this based on your specific requirements
    print('QR Code generated!');
  }

  void _showSectionSelectionDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Sections'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: _selectedSections.keys.map((String section) {
              return CheckboxListTile(
                title: Text(section),
                value: _selectedSections[section] ?? false,
                onChanged: (bool? value) {
                  setState(() {
                    _selectedSections[section] = value;
                  });
                },
              );
            }).toList(),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
    _shareQRCode();
  }

  Future<void> _shareQRCode() async {
    List<String> selectedEmails = [];

    _selectedSections.forEach((key, value) {
      if (value == true) {
        // Logic to select Gmail accounts based on the section
        // Here you can replace this with your actual logic to select Gmail accounts
        // For demonstration purposes, I'm just adding some dummy email addresses
        switch (key) {
          case 'Section A':
            selectedEmails.addAll([
              'student1.sectionA@gmail.com',
              'student2.sectionA@gmail.com',
              'student3.sectionA@gmail.com',
            ]);
            break;
          case 'Section B':
            selectedEmails.addAll([
              'student1.sectionB@gmail.com',
              'student2.sectionB@gmail.com',
              'student3.sectionB@gmail.com',
            ]);
            break;
          case 'Section C':
            selectedEmails.addAll([
              'student1.sectionC@gmail.com',
              'student2.sectionC@gmail.com',
              'student3.sectionC@gmail.com',
            ]);
            break;
          case 'Section D':
            selectedEmails.addAll([
              'student1.sectionD@gmail.com',
              'student2.sectionD@gmail.com',
              'student3.sectionD@gmail.com',
            ]);
            break;
        }
      }
    });

    if (selectedEmails.isNotEmpty) {
      final String subject = 'Attendance QR Code for ${DateFormat('yyyy-MM-dd').format(_selectedDate)}';
      final String body = 'Please find attached the QR Code for today\'s attendance.';
      final String attachment = ''; // Path to the QR code image file

      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: selectedEmails.join(','),
        queryParameters: {
          'subject': subject,
          'body': body,
          'attachment': attachment,
        },
      );

      try {
        await launch(emailLaunchUri.toString());
      } catch (e) {
        print('Error launching email: $e');
      }
    } else {
      // Show a message indicating that no section is selected
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select at least one section.'),
        ),
      );
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: QRCodeGenerator(),
  ));
}
