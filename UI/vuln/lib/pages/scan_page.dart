<<<<<<< HEAD
import 'package:flutter/material.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});
=======
// Created to display outcome of the scan once scan button was pressed

import 'package:flutter/material.dart';
import 'package:vuln/services/run_python.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);
>>>>>>> dfd6c94 (added backgroun/button)

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
<<<<<<< HEAD
  List<String> scannedFiles = []; // List to store scanned filenames
=======
  List<dynamic>? _scanResults;

  @override
  void initState() {
    super.initState();
    _runPythonScript();
  }

  Future<void> _runPythonScript() async {
    final result = await runPythonScript();

    setState(() {
      _scanResults = result;
    });
  }
>>>>>>> dfd6c94 (added backgroun/button)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
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
=======
        title: const Text('Scan Results'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          physics:
              const BouncingScrollPhysics(), // or AlwaysScrollableScrollPhysics()
          child: _buildResultView(),
        ),
      ),
      extendBody: true, // Extends the body behind the bottom navigation bar
    );
  }

  Widget _buildResultView() {
    if (_scanResults == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final result in _scanResults!) ..._buildResultDetails(result),
        ],
      );
    }
  }

  List<Widget> _buildResultDetails(Map<String, dynamic> result) {
    final detailsWidgets = <Widget>[];

    if (result['status'] == 'clean') {
      final directoryName = _extractDirectoryName(result['message']);
      detailsWidgets.add(Text('Directory $directoryName is clean.'));
    } else {
      detailsWidgets.add(const Text('Infected Files:'));

      final dynamic output = result['output'];

      if (output is List<dynamic>) {
        // Handle the case where output is a List<dynamic>
        for (final file in output) {
          detailsWidgets.add(Text('- $file'));
        }
      } else if (output is String) {
        // Handle the case where output is a String
        detailsWidgets.add(Text(output));
      } else {
        // Handle other cases if necessary
      }
    }

    return detailsWidgets;
  }

  String _extractDirectoryName(String message) {
    // Example: "/home/justin1/vuln/lib/main.dart is clean."
    final parts = message.split(' ');
    if (parts.length >= 2) {
      return parts[1];
    }
    return '';
  }
}
>>>>>>> dfd6c94 (added backgroun/button)
