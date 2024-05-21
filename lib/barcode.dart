import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/rendering.dart';

class QRCodeGenerator extends StatefulWidget {
  const QRCodeGenerator({Key? key}) : super(key: key);

  @override
  _QRCodeGeneratorState createState() => _QRCodeGeneratorState();
}

class _QRCodeGeneratorState extends State<QRCodeGenerator> {
  late String _inputValue;
  late TextEditingController _textEditingController;
  late DateTime _selectedDate;
  late String _location = ''; // Initialize location as empty string
  final GlobalKey _qrKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _inputValue = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _textEditingController = TextEditingController(text: _inputValue);
    _selectedDate = DateTime.now();
    _getLocation();
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
        Text(
          'Location: $_location',
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
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 300,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: RepaintBoundary(
                      key: _qrKey,
                      child: SfBarcodeGenerator(
                        value: '$_inputValue\n$_location', // Include location in QR code value
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
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: Icon(Icons.zoom_out_map, size: 30, color: Colors.black54),
                    onPressed: () {
                      _showFullScreenQRCode(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
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
    // Your logic to generate QR code based on selected date and location
    // You can implement this based on your specific requirements
    print('QR Code generated!');

    // Start the 5-minute timer
    _startTimer();
  }

  void _startTimer() async {
    // Timer duration is set to 5 minutes
    const duration = Duration(minutes: 5);
    // Wait for 5 minutes
    await Future.delayed(duration);
    // Once 5 minutes elapse, stop the QR code generation process
    print('QR Code generation time limit reached!');
  }

  Future<void> _showFullScreenQRCode(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(10),
            child: SfBarcodeGenerator(
              value: '$_inputValue\n$_location', // Include location in QR code value
              textAlign: TextAlign.justify,
              textSpacing: 10,
              symbology: QRCode(
                inputMode: QRInputMode.alphaNumeric,
                codeVersion: QRCodeVersion.auto,
                errorCorrectionLevel: ErrorCorrectionLevel.quartile,
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _location = '${position.latitude}, ${position.longitude}';
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: QRCodeGenerator(),
  ));
}
