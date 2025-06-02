import 'package:flutter/material.dart';

class Infopage extends StatefulWidget {
  const Infopage({super.key});

  @override
  State<Infopage> createState() => _InfopageState();
}

class _InfopageState extends State<Infopage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About This App"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/logo.png'),
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                "Stroke Prediction App",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text("v1.0.0", style: TextStyle(color: Colors.grey)),
            ),
            const SizedBox(height: 24),
            const Text(
              "About",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              "This app helps users predict the possibility of stroke based on personal health data inputs using machine learning models. It is intended for educational and early screening purposes only.",
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 24),
            const Text(
              "Developer",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Card(
              child: ListTile(
                leading: const Icon(Icons.person),
                title: const Text("Tento"),
                subtitle: const Text("Mobile Developer"),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Contact",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Card(
              child: ListTile(
                leading: const Icon(Icons.email),
                title: const Text("regartento@gmail.com"),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.link),
                title: const Text("github.com/Tento03"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
