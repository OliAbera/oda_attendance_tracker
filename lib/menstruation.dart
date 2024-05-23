import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(MenstruationApp());
}

class MenstruationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MenstruationScreen(),
    );
  }
}

class MenstruationScreen extends StatefulWidget {
  @override
  _MenstruationScreenState createState() => _MenstruationScreenState();
}

class _MenstruationScreenState extends State<MenstruationScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime? _focusedDay = DateTime.now();

  DateTime? _nextMenstruation;
  DateTime? _ovulationDay;
  DateTime? _lutealPhaseStart;
  DateTime? _follicularPhaseStart;

  @override
  void initState() {
    super.initState();
    _calculatePredictions();
  }

  void _calculatePredictions() {
    if (_selectedDay != null) {
      _nextMenstruation = _selectedDay.add(Duration(days: 28));
      _ovulationDay = _selectedDay.add(Duration(days: 14));
      _lutealPhaseStart = _selectedDay;
      _follicularPhaseStart = _ovulationDay;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menstruation Tracker'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TableCalendar(
              calendarFormat: _calendarFormat,
              focusedDay: _focusedDay!,
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                  _calculatePredictions();
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Menstruation Predictions:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            _buildPredictionTile('Next Menstruation', _nextMenstruation),
            _buildPredictionTile('Ovulation Day', _ovulationDay),
            _buildPredictionTile('Luteal Phase', _lutealPhaseStart, _ovulationDay),
            _buildPredictionTile('Follicular Phase', _ovulationDay, _nextMenstruation),
            SizedBox(height: 20),
            Text(
              'Lifestyle Advice:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            _buildAdviceTile('Luteal Phase', _lutealPhaseAdvice),
            _buildAdviceTile('Follicular Phase', _follicularPhaseAdvice),
            SizedBox(height: 20),
            Text(
              'Symptoms Advice:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            _buildAdviceTile('General Symptoms', _generalSymptomsAdvice),
          ],
        ),
      ),
    );
  }

  Widget _buildPredictionTile(String title, DateTime? date, [DateTime? endDate]) {
    String dateString = date != null ? date.toLocal().toString().split(' ')[0] : 'N/A';
    String endDateString = endDate != null ? endDate.toLocal().toString().split(' ')[0] : 'N/A';
    return ListTile(
      title: Text(title),
      subtitle: Text(endDate != null ? '$dateString to $endDateString' : dateString),
    );
  }

  Widget _buildAdviceTile(String title, List<String> advice) {
    return ExpansionTile(
      title: Text(title),
      children: advice.map((adviceText) => ListTile(title: Text(adviceText))).toList(),
    );
  }

  List<String> get _lutealPhaseAdvice => [
        'Eat foods rich in magnesium and calcium like nuts and leafy greens.',
        'Stay hydrated to help manage bloating.',
        'Engage in light exercise to boost mood.',
        'Prioritize sleep to combat fatigue.',
      ];

  List<String> get _follicularPhaseAdvice => [
        'Consume iron-rich foods to replenish blood loss.',
        'Include healthy fats in your diet for hormonal balance.',
        'Maintain regular exercise to support overall health.',
        'Focus on stress management techniques like meditation.',
      ];

  List<String> get _generalSymptomsAdvice => [
        'Track your symptoms to identify patterns.',
        'Consult with a healthcare provider for personalized advice.',
        'Consider using pain relief methods such as heating pads or over-the-counter medication.',
        'Maintain a balanced diet to support overall health.',
      ];
}
