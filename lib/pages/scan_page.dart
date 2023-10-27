// Created to display outcome of the scan once scan button was pressed

import 'package:flutter/material.dart';
import 'package:vuln/services/run_python.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
