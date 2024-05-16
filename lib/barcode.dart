import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:intl/intl.dart';

class QRCodeGenerator extends StatefulWidget {
  const QRCodeGenerator({Key? key}) : super(key: key);

  @override
  _QRCodeGeneratorState createState() => _QRCodeGeneratorState();
}

class _QRCodeGeneratorState extends State<QRCodeGenerator> {
  late String _inputValue;
  late TextEditingController _textEditingController;
  late DateTime _selectedDate;

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
}

void main() {
  runApp(MaterialApp(
    home: QRCodeGenerator(),
  ));
}