import 'package:flutter/material.dart';
import 'package:vuln/components/drawer_view.dart';
import 'dart:io';

class ScannerPage extends StatelessWidget {
  const ScannerPage({Key? key}) : super(key: key);

  void onButtonPressed(int buttonNumber) async {
    // Handle the button press based on the buttonNumber
    print('Scan $buttonNumber pressed');

    // Execute the Python script
    if (buttonNumber == 1) {
      try {
        print('Before executing Python script');
        await executePythonScript(
            '/home/justin1/CSC190/V.U.L.N/Scanning/CustomDirScan.py',
            '/home/justin1');
        print('After executing Python script');
      } catch (e) {
        print('Error in onButtonPressed: $e');
      }
    } else {
      print("Scan Not Initialized Yet");
    }
  }

  Future<void> executePythonScript(
      String scriptPath, String directoryPath) async {
    try {
      //print('Before process run');

      final process = await Process.run('python', [scriptPath, directoryPath]);
      //print('Inside executePythonScript');
      // Print the script output (stdout and stderr)
      print('Exit Code: ${process.exitCode}');
      print('stdout: ${process.stdout}');
      print('stderr: ${process.stderr}');
    } catch (e) {
      print('Error executing Python script: $e');
    }
  }

  String generateDescription(int scanNumber) {
    // Customize the descriptions based on the scan number
    if (scanNumber == 1) {
      return 'CustomDirScan.py';
    }
    if (scanNumber == 2) {
      return 'full dependency scan 2';
    }
    if (scanNumber == 3) {
      return 'Individual scan';
    }
    if (scanNumber == 4) {
      return 'high priority scan';
    }
    if (scanNumber == 5) {
      return 'quick scan';
    }
    if (scanNumber == 6) {
      return 'background scan';
    } else {
      return 'Custom Description for Scan $scanNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title:
            const Center(child: Text('Vulnerabilities Under Learned Network')),
      ),
      drawer: const DrawerView(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: const AssetImage('assets/images/honeycomb.jpg'),
            colorFilter: ColorFilter.mode(
              Theme.of(context).canvasColor,
              BlendMode.colorBurn,
            ),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: List.generate(
              5,
              (index) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyButton(
                    buttonText: 'Scan ${index * 2 + 1}',
                    descriptionText: generateDescription(index * 2 + 1),
                    onPressed: () => onButtonPressed(index * 2 + 1),
                  ),
                  MyButton(
                    buttonText: 'Scan ${index * 2 + 2}',
                    descriptionText: generateDescription(index * 2 + 2),
                    onPressed: () => onButtonPressed(index * 2 + 2),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  final String buttonText;
  final String descriptionText;
  final VoidCallback? onPressed;

  const MyButton({
    required this.buttonText,
    required this.descriptionText,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 100,
      width: 250,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        border: Border.all(color: Theme.of(context).cardColor),
      ),
      child: Column(
        children: [
          SizedBox(
            width: 150,
            height: 60,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: onPressed,
                child: Text(
                  buttonText,
                  style: TextStyle(color: Theme.of(context).indicatorColor),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(descriptionText),
        ],
      ),
    );
  }
}
