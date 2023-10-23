import 'package:flutter/material.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  List<String> scannedFiles = []; // List to store scanned filenames

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Button to simulate scanning a file
            ElevatedButton(
              onPressed: () {
                // Simulate scanning a file
                scanFile();
              },
              child: const Text('Scan File'),
            ),
            // Display scanned filenames in a scrollable column
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: scannedFiles.map((filename) {
                    return ListTile(
                      title: Text(filename),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to simulate scanning a file
  void scanFile() {
    setState(() {
      // Simulate getting a filename (replace this with your actual logic)
      String filename = 'File_${scannedFiles.length + 1}.txt';
      // Add the filename to the list
      scannedFiles.add(filename);
    });
  }
}