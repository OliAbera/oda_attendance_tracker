import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pie Chart Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PieChartPage(),
    );
  }
}

class PieChartPage extends StatefulWidget {
  @override
  _PieChartPageState createState() => _PieChartPageState();
}

class _PieChartPageState extends State<PieChartPage> {
  static const platform = MethodChannel('com.example.yourapp/screenshot');
  late List<PieData> _dataList = [];
  late TextEditingController _labelController;
  late TextEditingController _valueController;
  late TooltipBehavior _tooltipBehavior;
  final GlobalKey _chartKey = GlobalKey();
  File? _attachedImage;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _labelController = TextEditingController();
    _valueController = TextEditingController();
    _tooltipBehavior = TooltipBehavior(enable: true);
  }

  @override
  void dispose() {
    _labelController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  void _addData() {
    setState(() {
      final String label = _labelController.text;
      final double value = double.tryParse(_valueController.text) ?? 0.0;
      if (label.isNotEmpty && value > 0) {
        _dataList.add(PieData(label: label, value: value));
        _labelController.clear();
        _valueController.clear();
      }
    });
  }

  Future<void> _shareViaPlatform(String platform, File imageFile) async {
    final String text = 'Check out this pie chart!';
    if (platform == 'Telegram') {
      final String telegramUrl = 'https://t.me/share/url?url=${imageFile.path}&text=$text';
      if (await canLaunch(telegramUrl)) {
        await launch(telegramUrl);
      } else {
        print('Could not launch Telegram.');
      }
    } else if (platform == 'Instagram') {
      final String instagramUrl = 'instagram://share?url=${imageFile.path}';
      if (await canLaunch(instagramUrl)) {
        await launch(instagramUrl);
      } else {
        print('Could not launch Instagram.');
      }
    } else if (platform == 'Gmail') {
      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: '',
        query: 'subject=Pie Chart&body=$text',
      );
      final String emailUrl = emailLaunchUri.toString();
      if (await canLaunch(emailUrl)) {
        await launch(emailUrl);
      } else {
        print('Could not launch Gmail.');
      }
    }
  }

  void _captureScreenshotAndShare() async {
    try {
      RenderRepaintBoundary boundary =
          _chartKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final directory = await getApplicationDocumentsDirectory();
      final String path = directory.path;
      final File imgFile = File('$path/chart.png');
      await imgFile.writeAsBytes(pngBytes);

      _showPlatformSelectionDialog(imgFile);
    } catch (e) {
      print(e.toString());
    }
  }

  void _openCamera() async {
    try {
      await platform.invokeMethod('startSnippingTool');
    } on PlatformException catch (e) {
      print("Failed to start snipping tool: '${e.message}'.");
    }
  }

  void _showPlatformSelectionDialog(File imageFile) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Platform'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  child: Text('Telegram'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _shareViaPlatform('Telegram', imageFile);
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text('Instagram'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _shareViaPlatform('Instagram', imageFile);
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text('Gmail'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _shareViaPlatform('Gmail', imageFile);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickImage() async {
    final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _attachedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pie Chart Demo'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _labelController,
                    decoration: InputDecoration(
                      labelText: 'Label',
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: TextField(
                    controller: _valueController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Value',
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: _addData,
                  child: Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: RepaintBoundary(
              key: _chartKey,
              child: SfCircularChart(
                tooltipBehavior: _tooltipBehavior,
                series: <CircularSeries>[
                  PieSeries<PieData, String>(
                    dataSource: _dataList,
                    xValueMapper: (PieData data, _) => data.label,
                    yValueMapper: (PieData data, _) => data.value,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                    enableTooltip: true,
                    dataLabelMapper: (PieData data, _) => '${data.label}: ${data.value}',
                  ),
                ],
              ),
            ),
          ),
          _attachedImage != null
              ? Image.file(_attachedImage!)
              : Container(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                  onPressed: _openCamera,
                  child: Icon(Icons.camera_alt),
                ),
                ElevatedButton(
                  onPressed: _captureScreenshotAndShare,
                  child: Text('Share'),
                ),
                FloatingActionButton(
                  onPressed: _pickImage,
                  child: Icon(Icons.image),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PieData {
  final String label;
  final double value;

  PieData({
    required this.label,
    required this.value,
  });
}
