import 'dart:convert';

import 'package:console/console.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:vuln/components/drawer_view.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
//import 'package:vuln/components/mybutton.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:vuln/components/mybutton.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({Key? key}) : super(key: key);

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

String currentDirectory = Directory.current.path;

String pathToScanOne = '$currentDirectory/../../Scanning/CustomDirScan.py';
String pathToScanTwo = '$currentDirectory/../../Scanning/clamd_scan.py';
String pathToScanthree = '$currentDirectory/../../Scanning/swift_scan.py';
String pathToScanfour = '$currentDirectory/../../Scanning/clam_fullsys.py';

class _ScannerPageState extends State<ScannerPage> {
  //final TextEditingController textController = TextEditingController(); ##If you want the user to type in the file path
  String selectedFile = '';

  // Widget _buildScanPath(BuildContext context) {                 ##If you want the user to type in the file path
  //   return AlertDialog(
  //     title: const Text('Where Should I Scan?'),
  //     content: TextField(
  //       controller: textController,
  //       decoration: const InputDecoration(labelText: 'Enter Your File Path'),
  //     ),
  //     actions: <Widget>[
  //       TextButton(
  //         onPressed: () {
  //           Navigator.pop(context);
  //         },
  //         child: const Text('Cancel'),
  //       ),
  //       TextButton(
  //           onPressed: () async {
  //             await executePythonScript(pathToScanOne, textController.text);
  //           },
  //           child: const Text('Submit'))
  //     ],
  //   );
  // }

  // Future<void> startScan(BuildContext context) async { ##If you want the user to type in the file path
  //   showDialog(
  //       context: context, builder: ((context) => _buildScanPath(context)));
  // }

  Future<void> fetchProgress() async {
    String urlString = 'http://localhost:8000';
    Uri uri = Uri.parse(urlString);

// Now you can use the 'uri' object where a Uri is expected

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      // Parse and process progress messages from the response
      print(response.body);
    } else {
      // Handle error
      print('Error fetching progress: ${response.statusCode}');
    }
  }

  void showScanResultAlertDialog(BuildContext context, String scanResult) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Scan Result"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Text(scanResult),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Delete Files"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Quarantine"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void onButtonPressed(int buttonNumber) async {
    // Handle the button press based on the buttonNumber
    print('Scan $buttonNumber pressed');

    // Execute the Python script with progress updates
    if (buttonNumber == 1) {
      // Custom Directory Scan Logic
      // Pick file you wish to scan
      // Progress bar : Report
      await scanit(pathToScanOne);
    }
    if (buttonNumber == 2) {
      print("inside check 1");
      //Swift Scan
      await scanit(pathToScanthree);
    }

    if (buttonNumber == 3) {
      //fast scan
      scanit(pathToScanTwo);
    }
    if (buttonNumber == 4) {
      fullsys();
    } else {
      print("Scan not Initialized");
    }
  }

  Future<void> scanit(String scanfile) async {
    try {
      // Custom Directory Scan Logic
      // Pick file you wish to scan
      // Progress bar : Report
      // Open the file picker
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['*']);

      if (result != null) {
        String filePath = result.files.single.path!;
        setState(() {
          selectedFile = filePath;
        });

        print('Selected path: $filePath');

        ProgressDialog progressDialog = ProgressDialog(context);
        progressDialog.style(
          message: 'Scanning...',
          messageTextStyle:
              TextStyle(color: Theme.of(context).highlightColor.withOpacity(1)),
          progressWidget: const CircularProgressIndicator.adaptive(
            backgroundColor: Colors.deepPurple,
            strokeWidth: 5.5,
          ),
          textAlign: TextAlign.center,
          backgroundColor: Theme.of(context).cardColor,
        );

        progressDialog.show();

        // Define a variable to store the scan result
        String scanResult = '';

        // Execute the Python script with a callback for progress updates
        await executePythonScript(
          scanfile,
          selectedFile,
          (progress) {
            // Update the progress dialog with the received progress
            print(progress);
            scanResult = progress;
            //showScanResultAlertDialog(context, scanResult);
            //progressDialog.hide();
            progressDialog.update(message: "Complete");
          },
        );
        progressDialog.hide();
        showScanResultAlertDialog(context, scanResult);
      } else {
        // User canceled the file picker
        print('User canceled file picker');
      }
    } catch (e) {
      print('Error in onButtonPressed: $e');
    }
  }

  Future<void> fullsys() async {
    //Full system scan
    try {
      // Custom Directory Scan Logic
      // Pick file you wish to scan
      // Progress bar : Report
      // Open the file picker

      ProgressDialog progressDialog = ProgressDialog(context);
      progressDialog.style(
        message: 'Scanning...',
        progressWidget: const CircularProgressIndicator(),
      );

      progressDialog.show();

      // Define a variable to store the scan result
      String scanResult = '';

      // Execute the Python script with a callback for progress updates
      await executePythonScript(
        pathToScanfour,
        '/',
        (progress) {
          // Update the progress dialog with the received progress
          print(progress);
          scanResult = progress;

          //showScanResultAlertDialog(context, scanResult);
          //progressDialog.hide();
          progressDialog.update(message: "Complete");
        },
      );
      progressDialog.hide();
      // ignore: use_build_context_synchronously
      showScanResultAlertDialog(context, scanResult);
    } catch (e) {
      print('Error in onButtonPressed: $e');
    }
  }

  Future<void> executePythonScript(
    String scriptPath,
    String directoryPath,
    Function(String) updateProgress,
  ) async {
    try {
      final process =
          await Process.start('python', [scriptPath, directoryPath]);

      process.stdout.transform(utf8.decoder).listen((String data) {
        // Update the progress based on the data received from the script

        print('This is the data: $data');
        updateProgress(data);
      });

      await process.exitCode;
    } catch (e) {
      print('Error executing Python script: $e');
    }
  }

  String generateDescription(int scanNumber) {
    // Customize the descriptions based on the scan number
    if (scanNumber == 1) {
      return """Efficient with larger directories""";
    }
    if (scanNumber == 2) {
      return """More thorough then a fast scan""";
    }
    if (scanNumber == 3) {
      return """Use on singular files and small directories""";
    }
    if (scanNumber == 4) {
      return """May take some time to complete""";
    } else {
      return 'Custom Description for Scan $scanNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              2,
              (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: size.height * 0.35,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: Theme.of(context).highlightColor,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: MyButton(
                        size: size,
                        buttonText: index == 0 ? "Directory Scan" : "Fast Scan",
                        descriptionText: generateDescription(index * 2 + 1),
                        onPressed: () => onButtonPressed(index * 2 + 1),
                      ),
                    ),
                    Container(
                      height: size.height * 0.35,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: Theme.of(context).highlightColor,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: MyButton(
                        size: size,
                        buttonText:
                            index == 1 ? "Full System Scan" : "Swift Scan",
                        descriptionText: generateDescription(index * 2 + 2),
                        onPressed: () => onButtonPressed(index * 2 + 2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
