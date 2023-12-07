import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vuln/components/drawer_view.dart';
import 'package:vuln/components/themeprovider.dart';
import 'package:vuln/pages/home_page.dart';

//import 'package:vuln/components/scan_now.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Center(
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ));
                },
                child: const Text('Vulnerabilities Under Learned Network'))),
      ),
      drawer: const DrawerView(),
      body: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return Container(
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
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BackgroundDropdown(),
                SizedBox(
                  height: 100,
                ),
                Text(
                  "Version 1.0 Settings",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class BackgroundDropdown extends StatefulWidget {
  const BackgroundDropdown({super.key});

  @override
  State<BackgroundDropdown> createState() => _DropdownExampleState();
}

String currentDirectory = Directory.current.parent.parent.path;
String pathschedulescan = '$currentDirectory/Scanning/scheduler.py';
String pathcustomdir = '$currentDirectory/Scanning/CustomDirScan.py';
String defaultlog = '$currentDirectory/Scanning/sch_scan_results.log';
String updatesigpath = '$currentDirectory/Scanning/Scheduled_restart.py';

class _DropdownExampleState extends State<BackgroundDropdown> {
  String selectedValue = 'Red'; // Default selected value
  TimeOfDay selectedTime = TimeOfDay.now(); // Default selected time
  String formattedTime = '';
  String customlogfile = '';
  String directorytoscan = '';

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    Size dimension = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: dimension.width * 0.4,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withAlpha(170),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    value: selectedValue,
                    alignment: Alignment.centerRight,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue!;
                        themeProvider.setTheme(selectedValue);
                      });
                    },
                    items: <String>['Dark', 'Light', 'Blue', 'Red', 'Green']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              value,
                              style:
                                  TextStyle(fontSize: dimension.width * 0.025),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Background Color: $selectedValue',
          style: TextStyle(
              color: Theme.of(context).hintColor,
              backgroundColor: Theme.of(context).primaryColor),
        ),
        const SizedBox(height: 20),
        Container(
          width: dimension.width * 0.5,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withAlpha(170),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Schedule Time:',
                    style: TextStyle(
                        color: Colors.white, fontSize: dimension.width * 0.03),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    final TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: selectedTime,
                    );

                    if (pickedTime != null && pickedTime != selectedTime) {
                      String normalTime =
                          _formatTime(selectedTime.hour, selectedTime.minute);
                      setState(() {
                        selectedTime = pickedTime;
                        formattedTime = normalTime;
                      });
                      FilePickerResult? result;
                      result = await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['directory'],
                          allowMultiple: false);
                      if (result != null) {
                        String filepath = result.files.single.path!;
                        setState(() {
                          directorytoscan = filepath;
                        });
                      }
                      executeFreshclamScript(updatesigpath);

                      executePythonScript(
                          '${selectedTime.hour}:${selectedTime.minute}:00',
                          pathschedulescan,
                          directorytoscan,
                          customlogfile,
                          pathcustomdir);
                    }
                  },
                  child: Text(
                    'Schedule Scan',
                    style: TextStyle(fontSize: dimension.width * 0.021),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () async {
                    FilePickerResult? result;
                    result = await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['log'],
                        allowMultiple: false);
                    if (result != null) {
                      String filePath = result.files.single.path!;
                      setState(() {
                        customlogfile = filePath;
                      });
                      print(filePath);
                    }
                    setState(() {
                      customlogfile = defaultlog;
                    });
                  },
                  child: const Text('Change Logfile Location')),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                        'Time Selected in Military Time: ${selectedTime.hour}:${selectedTime.minute}'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text('Time Selected: $formattedTime'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text('Your Logfile is stored at: $customlogfile'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void executePythonScript(String time, String scriptpath, String filePath,
      String logFile, String customdir) {
    try {
      // Construct the command to execute the Python script
      String pythonScript = 'python';

      if (logFile == '') {
        logFile = './sch_scan_results.log';
      }

      List<String> arguments = [
        scriptpath,
        time,
        filePath,
        logFile,
        customdir,
      ];

      // Execute the command
      ProcessResult result = Process.runSync(pythonScript, arguments);

      // Print the output of the Python script
      print(result.stdout);

      // Print any errors that occurred during execution
      if (result.stderr != null && result.stderr.isNotEmpty) {
        print(result.stderr);
      }
    } catch (e) {
      print("Error executing Python script: $e");
    }
  }

  void executeFreshclamScript(String scriptpath) {
    try {
      // Construct the command to execute the Python script
      String pythonScript = 'python';

      List<String> arguments = [
        scriptpath,
      ];

      // Execute the command
      ProcessResult result = Process.runSync(pythonScript, arguments);

      // Print the output of the Python script
      print(result.stdout);

      // Print any errors that occurred during execution
      if (result.stderr != null && result.stderr.isNotEmpty) {
        print(result.stderr);
      }
    } catch (e) {
      print("Error executing Python script: $e");
    }
  }

  String _formatTime(int hour, int minute) {
    String period = 'AM';
    if (hour >= 12) {
      period = 'PM';
      if (hour > 12) {
        hour -= 12;
      }
      if (hour == 00) {
        hour = 12;
      }
    }
    return '$hour:${minute.toString().padLeft(2, '0')} $period';
  }
}
