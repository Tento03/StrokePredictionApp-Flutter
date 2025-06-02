import 'package:flutter/material.dart';
import 'package:strokeprediction/ui/ScanPage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Stroke Prediction",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Halo,\nPrediksi Diabetes Anda Dengan Cepat',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Tombol Scan
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Scanpage()),
                );
              },
              icon: const Icon(Icons.camera_alt),
              label: const Text('Scan Sekarang'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(height: 40),

            // Edukasi
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Edukasi Kesehatan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 16),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Apa itu Diabetes'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Tips Pola Makan Sehat'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Pentingnya Olahraga'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
