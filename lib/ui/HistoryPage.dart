import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:strokeprediction/model/History.dart';

class Historypage extends StatefulWidget {
  const Historypage({super.key});

  @override
  State<Historypage> createState() => _HistorypageState();
}

class _HistorypageState extends State<Historypage> {
  final Box<History> historyBox = Hive.box<History>('historyBox');
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  String gender = 'Male';

  void showHistoryDialog({History? history, int? index}) {
    if (history != null) {
      nameController.text = history.name;
      ageController.text = history.age;
      gender = history.gender;
    } else {
      nameController.clear();
      ageController.clear();
    }

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Edit History'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  keyboardType: TextInputType.name,
                ),
                TextField(
                  controller: ageController,
                  decoration: InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.name,
                ),
                DropdownButton(
                  value: gender,
                  isExpanded: true,
                  items:
                      ['Male', 'Female']
                          .map(
                            (e) => DropdownMenuItem(child: Text(e), value: e),
                          )
                          .toList(),
                  onChanged: (value) => gender = value!,
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  final name = nameController.text;
                  final age = ageController.text;

                  history?.name = name;
                  history?.age = age;
                  history?.gender = gender;
                  history?.save();
                  Navigator.pop(context);
                  setState(() {});
                },
                child: Text('Edit'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prediction History'),
        backgroundColor: Colors.green,
      ),
      body: ValueListenableBuilder(
        valueListenable: historyBox.listenable(),
        builder: (context, Box<History> box, _) {
          if (box.values.isEmpty) {
            return const Center(child: Text('No history available.'));
          }
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final history = box.getAt(index);
              if (history == null) return const SizedBox();

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                elevation: 4,
                child: ListTile(
                  title: Text(history.name),
                  subtitle: Text(
                    'Age: ${history.age}, Gender: ${history.gender}\n'
                    'Prediction: ${history.prediction}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          showHistoryDialog(history: history, index: index);
                        },
                        icon: Icon(Icons.edit, color: Colors.red),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          box.deleteAt(index);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
