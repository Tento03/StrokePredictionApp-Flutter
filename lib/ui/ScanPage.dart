import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:strokeprediction/model/History.dart';

class Scanpage extends StatefulWidget {
  const Scanpage({super.key});

  @override
  State<Scanpage> createState() => _ScanpageState();
}

class _ScanpageState extends State<Scanpage> {
  final key = GlobalKey<FormState>();
  final Box historyBox = Hive.box<History>('historyBox');

  final name = TextEditingController();
  String gender = 'Male';
  final ageController = TextEditingController();
  String hypertension = 'No';
  String heartDisease = 'No';
  String everMarried = 'No';
  String workType = 'Private';
  String residenceType = 'Urban';
  final avgGlucoseLevel = TextEditingController();
  final bmiController = TextEditingController();
  String smokingStatus = 'No';
  String? prediction;

  // Mapping functions
  int mapYesNo(String value) => value == 'Yes' ? 1 : 0;

  int mapGender(String value) => value == 'Yes' ? 1 : 0;

  int mapWorkType(String value) {
    switch (value) {
      case 'Private':
        return 0;
      case 'Self-Employed': // koreksi typo
        return 1;
      default:
        return 0;
    }
  }

  int mapResidenceType(String value) => value == 'Urban' ? 0 : 1;

  int mapSmokingStatus(String value) => value == 'Yes' ? 1 : 0;

  Future<void> postData() async {
    if (!key.currentState!.validate()) {
      setState(() {
        prediction = 'Please fill all fields correctly.';
      });
      return;
    }

    List<dynamic> input = [
      mapGender(gender),
      double.tryParse(ageController.text) ?? 0,
      mapYesNo(hypertension),
      mapYesNo(heartDisease),
      mapYesNo(everMarried),
      mapWorkType(workType),
      mapResidenceType(residenceType),
      double.tryParse(avgGlucoseLevel.text) ?? 0,
      double.tryParse(bmiController.text) ?? 0,
      mapSmokingStatus(smokingStatus),
    ];

    var uri = Uri.parse('http://192.168.1.15:5000/predict');
    try {
      var response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'input': input}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Response body: ${response.body}');
        setState(() {
          prediction =
              data['prediction']
                  .toString(); // perhatikan 'prediction' lowercase sesuai flask
          historyBox.add(
            History(
              name: name.text,
              gender: gender,
              age: ageController.text,
              hypertension: hypertension,
              heartDisease: heartDisease,
              everMarried: everMarried,
              workType: workType,
              residenceType: residenceType,
              avgGlucoseLevel: avgGlucoseLevel.text,
              bmi: bmiController.text,
              smokingStatus: smokingStatus,
              prediction: prediction ?? 'null',
            ),
          );
        });
      } else {
        final errorData = jsonDecode(response.body);
        print('Error prediction: ${errorData['message']}');
        setState(() {
          prediction = 'Error: ${errorData['message']}';
        });
      }
    } catch (e) {
      setState(() {
        prediction = 'Error: $e';
      });
    }
  }

  @override
  void dispose() {
    ageController.dispose();
    avgGlucoseLevel.dispose();
    bmiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Form Stroke Scan',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: key,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: TextField(
                  controller: name,
                  decoration: InputDecoration(labelText: 'Name'),
                  style: TextStyle(),
                  keyboardType: TextInputType.name,
                ),
              ),
              DropdownCard(
                label: 'Gender',
                value: gender,
                items: ['Male', 'Female'],
                onChanged: (val) => setState(() => gender = val!),
              ),
              textInput('Age', ageController),
              DropdownCard(
                label: 'Hypertension',
                value: hypertension,
                items: ['Yes', 'No'],
                onChanged: (val) => setState(() => hypertension = val!),
              ),
              DropdownCard(
                label: 'Heart Disease',
                value: heartDisease,
                items: ['Yes', 'No'],
                onChanged: (val) => setState(() => heartDisease = val!),
              ),
              DropdownCard(
                label: 'Ever Married',
                value: everMarried,
                items: ['Yes', 'No'],
                onChanged: (val) => setState(() => everMarried = val!),
              ),
              DropdownCard(
                label: 'Work Type',
                value: workType,
                items: ['Private', 'Self-Employed'], // koreksi typo
                onChanged: (val) => setState(() => workType = val!),
              ),
              DropdownCard(
                label: 'Residence Type',
                value: residenceType,
                items: ['Urban', 'Rural'],
                onChanged: (val) => setState(() => residenceType = val!),
              ),
              textInput('Glucose Level', avgGlucoseLevel),
              textInput('BMI', bmiController),
              DropdownCard(
                label: 'Smoking Status',
                value: smokingStatus,
                items: ['Yes', 'No'],
                onChanged: (val) => setState(() => smokingStatus = val!),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: postData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Predict',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              if (prediction != null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Prediction result: $prediction',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textInput(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          if (double.tryParse(value) == null) {
            return '$label must be a number';
          }
          return null;
        },
      ),
    );
  }
}

class DropdownCard extends StatelessWidget {
  final String label;
  final String value;
  final List<String> items;
  final Function(String?) onChanged;

  const DropdownCard({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: DropdownButtonFormField<String>(
          isExpanded: true,
          decoration: InputDecoration(labelText: label),
          value: value,
          items:
              items
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
          onChanged: onChanged,
          validator:
              (value) =>
                  value == null || value.isEmpty
                      ? 'Please select $label'
                      : null,
        ),
      ),
    );
  }
}
