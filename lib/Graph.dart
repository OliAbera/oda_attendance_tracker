import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chart Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChartGeneratorPage(),
    );
  }
}

class ChartGeneratorPage extends StatefulWidget {
  @override
  _ChartGeneratorPageState createState() => _ChartGeneratorPageState();
}

class _ChartGeneratorPageState extends State<ChartGeneratorPage> {
  final List<ChartData> data = [];
  final TextEditingController _valueController = TextEditingController();

  void _addValue() {
    if (_valueController.text.isNotEmpty) {
      setState(() {
        data.add(ChartData(data.length, double.parse(_valueController.text)));
        _valueController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chart Generator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _valueController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter a value',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addValue,
              child: Text('Add Value'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: data
                          .map((dataPoint) => FlSpot(dataPoint.index.toDouble(), dataPoint.value))
                          .toList(),
                      isCurved: true,
                      barWidth: 4,
                      color: Colors.blue,
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.blue.withOpacity(0.3),
                      ),
                    ),
                  ],
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toString(),
                            style: TextStyle(color: Colors.black, fontSize: 10),
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 22,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toString(),
                            style: TextStyle(color: Colors.black, fontSize: 10),
                          );
                        },
                      ),
                    ),
                  ),
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: true),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  final int index;
  final double value;

  ChartData(this.index, this.value);
}
