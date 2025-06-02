import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:strokeprediction/model/History.dart';
import 'package:strokeprediction/ui/HistoryPage.dart';
import 'package:strokeprediction/ui/HomePage.dart';
import 'package:strokeprediction/ui/InfoPage.dart';
import 'package:strokeprediction/ui/ScanPage.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(HistoryAdapter());
  await Hive.openBox<History>('historyBox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: BottomPage());
  }
}

class BottomPage extends StatefulWidget {
  const BottomPage({super.key});

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  int selectedIndex = 0;
  List<Widget> pages = [Homepage(), Scanpage(), Historypage(), Infopage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        backgroundColor: Colors.yellowAccent,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.scanner), label: 'Scan'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Info'),
        ],
      ),
    );
  }
}
