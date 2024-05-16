import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PointColorMapper extends StatefulWidget {
  const PointColorMapper({Key? key}) : super(key: key);

  @override
  _PointColorMapperState createState() => _PointColorMapperState();
}

class _PointColorMapperState extends State<PointColorMapper> {
  TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true);
  List<ChartSampleData> chartData = <ChartSampleData>[
    ChartSampleData(x: 'Jan', attendance: 80, absence: 20),
    ChartSampleData(x: 'Feb', attendance: 85, absence: 15),
    ChartSampleData(x: 'Mar', attendance: 75, absence: 25),
    ChartSampleData(x: 'Apr', attendance: 90, absence: 10),
    ChartSampleData(x: 'May', attendance: 70, absence: 30),
    ChartSampleData(x: 'Jun', attendance: 95, absence: 5),
    ChartSampleData(x: 'Jul', attendance: 82, absence: 18),
    ChartSampleData(x: 'Aug', attendance: 88, absence: 12),
    ChartSampleData(x: 'Sep', attendance: 78, absence: 22),
    ChartSampleData(x: 'Oct', attendance: 92, absence: 8),
    ChartSampleData(x: 'Nov', attendance: 86, absence: 14),
    ChartSampleData(x: 'Dec', attendance: 79, absence: 21),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 60),
      child: _buildPointColorMapperChart(),
    );
  }

  SfCartesianChart _buildPointColorMapperChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: 'Attendance Rate'),
      primaryXAxis: CategoryAxis(majorGridLines: MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
        labelFormat: '{value}%',
        minimum: 0,
        maximum: 100,
        interval: 10,
        axisLine: AxisLine(width: 0),
        majorTickLines: MajorTickLines(color: Colors.transparent),
      ),
      tooltipBehavior: _tooltipBehavior,
      series: <CartesianSeries<ChartSampleData, String>>[
        ColumnSeries<ChartSampleData, String>(
          dataSource: chartData,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.attendance,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          name: 'Present',
          color: Colors.blue, // Blue color for present students
        ),
        ColumnSeries<ChartSampleData, String>(
          dataSource: chartData,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.absence,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          name: 'Absent',
          color: Colors.red, // Red color for absent students
        ),
      ],
    );
  }
}

class ChartSampleData {
  final String x;
  final int attendance;
  final int absence;

  ChartSampleData({required this.x, required this.attendance, required this.absence});
}