import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddTeacher2Page extends StatefulWidget {
  @override
  _AddTeacher2PageState createState() => _AddTeacher2PageState();
}

class _AddTeacher2PageState extends State<AddTeacher2Page> {
  List<TeacherInfo> addedTeachers = [];
  List<TeacherInfo> removedTeachers = [];
  String teacherName = '';
  DateTime? joiningDate;
  TimeOfDay? joiningTime;
  String mobileNumber = '';
  String teacherSubject = '';
  String teacherGrade = '';
  String teacherSection = '';
  String teacherSex = '';
  String? teacherImageURL;

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != joiningDate)
      setState(() {
        joiningDate = picked;
        _dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != joiningTime)
      setState(() {
        joiningTime = picked;
        _timeController.text = picked.format(context);
      });
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        teacherImageURL = pickedFile.path;
      });
    }
  }

  void addTeacher() {
    if (teacherName.isNotEmpty && teacherSubject.isNotEmpty && teacherGrade.isNotEmpty && teacherSection.isNotEmpty && mobileNumber.isNotEmpty && joiningDate != null && joiningTime != null && teacherSex.isNotEmpty) {
      setState(() {
        addedTeachers.add(TeacherInfo(
          name: teacherName,
          subject: teacherSubject,
          section: teacherSection,
          grade: teacherGrade,
          mobile: mobileNumber,
          sex: teacherSex,
          joiningDateTime: DateTime(joiningDate!.year, joiningDate!.month, joiningDate!.day, joiningTime!.hour, joiningTime!.minute),
          image: teacherImageURL,
        ));
        teacherName = '';
        teacherSubject = '';
        teacherGrade = '';
        teacherSection = '';
        mobileNumber = '';
        teacherSex = '';
        joiningDate = null;
        joiningTime = null;
        teacherImageURL = null;
        _dateController.clear();
        _timeController.clear();
      });
    }
  }

  void removeTeacher(String teacher) {
    setState(() {
      addedTeachers.removeWhere((info) => info.name == teacher);
      removedTeachers.add(addedTeachers.firstWhere((info) => info.name == teacher));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add/Remove Student'),
        actions: [
          IconButton(
            icon: Icon(Icons.visibility),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TeacherListPage(addedTeachers, removedTeachers)),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Name:',
              style: TextStyle(fontSize: 16),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter student name',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  teacherName = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'Joining Date:',
              style: TextStyle(fontSize: 16),
            ),
            TextFormField(
              controller: _dateController,
              decoration: InputDecoration(
                hintText: 'Select joining date',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              onTap: _pickDate,
              readOnly: true,
            ),
            SizedBox(height: 16.0),
            Text(
              'Joining Time:',
              style: TextStyle(fontSize: 16),
            ),
            TextFormField(
              controller: _timeController,
              decoration: InputDecoration(
                hintText: 'Select joining time',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.access_time),
              ),
              onTap: _pickTime,
              readOnly: true,
            ),
            SizedBox(height: 16.0),
            Text(
              'Mobile Number:',
              style: TextStyle(fontSize: 16),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter mobile number',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  mobileNumber = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            ExpansionTile(
              title: Text('Select Subject'),
              children: <Widget>[
                ListTile(
                  title: Text('Mathematics'),
                  onTap: () {
                    setState(() {
                      teacherSubject = 'Mathematics';
                    });
                  },
                ),
                ListTile(
                  title: Text('Physics'),
                  onTap: () {
                    setState(() {
                      teacherSubject = 'Physics';
                    });
                  },
                ),
                ListTile(
                  title: Text('Biology'),
                  onTap: () {
                    setState(() {
                      teacherSubject = 'Biology';
                    });
                  },
                ),
                ListTile(
                  title: Text('Chemistry'),
                  onTap: () {
                    setState(() {
                      teacherSubject = 'Chemistry';
                    });
                  },
                ),
                 ListTile(
                  title: Text('ICT'),
                  onTap: () {
                    setState(() {
                      teacherSubject = 'ICT';
                    });
                  },
                ),
                ListTile(
                  title: Text('English'),
                  onTap: () {
                    setState(() {
                      teacherSubject = 'English';
                    });
                  },
                ),
                 ListTile(
                  title: Text('Agriculture'),
                  onTap: () {
                    setState(() {
                      teacherSubject = 'Agriculture';
                    });
                  },
                ),
                ListTile(
                  title: Text('Afaan Oromoo'),
                  onTap: () {
                    setState(() {
                      teacherSubject = 'Afaan Oromoo';
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Grade:',
              style: TextStyle(fontSize: 16),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter grade',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  teacherGrade = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'Section:',
              style: TextStyle(fontSize: 16),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter section',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  teacherSection = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'Sex:',
              style: TextStyle(fontSize: 16),
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                hintText: 'Select sex',
                border: OutlineInputBorder(),
              ),
              items: ['Male', 'Female'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  teacherSex = newValue!;
                });
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'Upload Image:',
              style: TextStyle(fontSize: 16),
            ),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  icon: Icon(Icons.photo),
                  label: Text('From Gallery'),
                ),
                SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.camera),
                  icon: Icon(Icons.camera_alt),
                  label: Text('From Camera'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: addTeacher,
                  child: Text('Add Teacher'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (teacherName.isNotEmpty) {
                      removeTeacher(teacherName);
                    }
                  },
                  child: Text('Remove Teacher'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TeacherListPage extends StatelessWidget {
  final List<TeacherInfo> addedTeachers;
  final List<TeacherInfo> removedTeachers;

  TeacherListPage(this.addedTeachers, this.removedTeachers);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher List'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Added Teachers:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: addedTeachers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: addedTeachers[index].image != null
                      ? Image.network(
                          addedTeachers[index].image!,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                      : Icon(Icons.person),
                  title: Text(
                    '${addedTeachers[index].name} - ${addedTeachers[index].subject} - ${addedTeachers[index].grade} - ${addedTeachers[index].section} - ${addedTeachers[index].joiningDateTime}',
                    style: TextStyle(color: Colors.green),
                  ),
                );
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'Removed Teachers:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: removedTeachers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: removedTeachers[index].image != null
                      ? Image.network(
                          removedTeachers[index].image!,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                      : Icon(Icons.person),
                  title: Text(
                    '${removedTeachers[index].name} - ${removedTeachers[index].subject} - ${removedTeachers[index].grade} - ${removedTeachers[index].section} - ${removedTeachers[index].joiningDateTime}',
                    style: TextStyle(color: Colors.red),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TeacherInfo {
  final String name;
  final String subject;
  final String grade;
  final String section;
  final String mobile;
  final String sex;
  final DateTime joiningDateTime;
  final String? image;

  TeacherInfo({
    required this.name,
    required this.subject,
    required this.grade,
    required this.section,
    required this.mobile,
    required this.sex,
    required this.joiningDateTime,
    this.image,
  });
}


