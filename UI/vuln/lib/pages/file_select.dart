import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:vuln/components/drawer_view.dart';
import 'package:vuln/components/mybutton.dart';

class FileSPage extends StatefulWidget {
  const FileSPage({super.key});

  @override
  State<FileSPage> createState() => _FileSPageState();
}

class _FileSPageState extends State<FileSPage> {
  String selectedFile = '';

  void showScanResultAlertDialog(BuildContext context, String scanResult) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Scan Result"),
          content: Text(scanResult),
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

  Future<String> executePythonScript(
      String scriptPath, String directoryPath) async {
    try {
      print('Executing Python script: python $scriptPath $directoryPath');
      final process = await Process.run('python', [scriptPath, directoryPath]);
      print('Exit Code: ${process.exitCode}');
      print('stdout: ${process.stdout}');
      print('stderr: ${process.stderr}');
      return process.stdout;
    } catch (e) {
      print('Error executing Python script: $e');
      return "error";
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // Get the current working directory of the Dart script
    String currentDirectory = Directory.current.path;

    // Construct the relative path to clamd_scan.py
    String pathToScanOne = '$currentDirectory/../../Scanning/clamd_scan.py';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title:
            const Center(child: Text('Vulnerabilities Under Learned Network')),
      ),
      drawer: const DrawerView(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Theme.of(context).secondaryHeaderColor,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: const AssetImage('assets/images/honeycomb.jpg'),
            colorFilter: ColorFilter.mode(
              Theme.of(context).canvasColor,
              BlendMode.colorBurn,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Container(
                width: size.width * 0.3,
                height: size.height * 0.52,
                decoration: BoxDecoration(
                  color: Theme.of(context).secondaryHeaderColor,
                  border: Border.all(),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("Step 1", style: TextStyle(fontSize: 40)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "To select a File press: ",
                            style: TextStyle(fontSize: 20),
                          ),
                          ElevatedButton(
                            autofocus: true,
                            onPressed: () async {
                              FilePickerResult? result = await FilePicker
                                  .platform
                                  .pickFiles(type: FileType.any);

                              if (result != null) {
                                String filePath = result.files.single.path!;
                                setState(() {
                                  selectedFile = filePath;
                                });

                                print('Selected path: $filePath');
                              } else {
                                print('User canceled file picker');
                              }
                            },
                            child: Text(
                              'Choose File',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: size.width * 0.3,
                height: size.height * 0.52,
                decoration: BoxDecoration(
                  color: Theme.of(context).secondaryHeaderColor,
                  border: Border.all(),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Step 2",
                        style: TextStyle(fontSize: 40),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("The file path you selected is: "),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          selectedFile,
                          style: TextStyle(
                              color: Theme.of(context).hintColor,
                              fontSize: size.height * .023,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyButton(
                              size: size * .8,
                              buttonText: 'Scan Now',
                              descriptionText: "",
                              onPressed: () async {
                                try {
                                  if (selectedFile != "") {
                                    String scanResult =
                                        await executePythonScript(
                                            pathToScanOne, selectedFile);
                                    showScanResultAlertDialog(
                                        context, scanResult);
                                  } else {}
                                } catch (e) {
                                  print("Error in file select");
                                }
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
