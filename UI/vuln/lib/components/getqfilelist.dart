import 'dart:io';
import 'package:path/path.dart' as path;

import 'package:flutter/material.dart';
import 'package:vuln/services/delete_file.dart';
import 'package:vuln/services/getquarantined.dart';
import 'package:vuln/services/update.dart';

class QuarantinedFilesList extends StatefulWidget {
  const QuarantinedFilesList({super.key});

  @override
  State<QuarantinedFilesList> createState() => _QuarantinedFilesListState();
}

class _QuarantinedFilesListState extends State<QuarantinedFilesList> {
  late Future<Iterable<Map<String, dynamic>>> _quarantinedFiles;

  @override
  void initState() {
    super.initState();
    _quarantinedFiles = getQuarantinedFiles();
  }

  String selectedFile = '';
  void showScanResultAlertDialog(
      BuildContext context, String scanResult, String pathtoremove) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: const Text("Scan Result"),
          content: Text(scanResult),
          actions: [
            TextButton(
              onPressed: () async {
                await _deleteFileName(selectedFile);
                await removeScript(pathtoremove, selectedFile);
                setState(() {
                  selectedFile = '';
                  _quarantinedFiles = getQuarantinedFiles();
                });
                Navigator.of(context).pop();
              },
              child: const Text("Delete File"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  selectedFile = '';
                });
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
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

  Future<String> removeScript(String scriptPath, String abs) async {
    try {
      print('Executing Python script: python $scriptPath $abs');
      final process = await Process.run('python', [scriptPath, abs]);
      print('Exit Code: ${process.exitCode}');
      print('stdout: ${process.stdout}');
      print('stderr: ${process.stderr}');
      return process.stdout;
    } catch (e) {
      print('Error executing Python script: $e');
      return "error";
    }
  }

  Future<String> quarantineScript(
      String scriptPath, String abs_file, String quarantine_folder) async {
    try {
      print(
          'Executing Python script: python $scriptPath $abs_file $quarantine_folder');
      final process = await Process.run(
          'python', [scriptPath, abs_file, quarantine_folder]);
      print('Exit Code: ${process.exitCode}');
      print('stdout: ${process.stdout}');
      print('stderr: ${process.stderr}');
      var temp = _extractFileName(abs_file);
      final updateData = {'quarantine': true};
      await updateFile(temp, updateData);
      return process.stdout;
    } catch (e) {
      print('Error executing Python script: $e');
      return "error";
    }
  }

  bool containsFound(String inputString) {
    return inputString.toLowerCase().contains('found');
  }

  String _extractFileName(String absolutepath) {
    // Extract file name from the absolute path
    String fileName = path.basename(absolutepath);

    return fileName;
  }

  Future<void> _deleteFileName(String absolutepath) async {
    // Extract file name from the absolute path
    String fileName = _extractFileName(selectedFile);

    await deleteFile(fileName);
  }

  @override
  Widget build(BuildContext context) {
    String currentDirectory = Directory.current.path;

    String pathToremove = '$currentDirectory/../../remove.py';
    String pathToquarantine = '$currentDirectory/../../quarantine.py';

    return FutureBuilder<Iterable<Map<String, dynamic>>>(
      future: _quarantinedFiles,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No quarantined files available.');
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final file = snapshot.data!.elementAt(index);
              return ListTile(
                title: Text('File: ${file['file']}'),
                subtitle: Text('File Path: ${file['file_path']}'),
                onTap: () {
                  print(file['file']);
                  setState(() {
                    selectedFile = file['file'];
                  });
                  showScanResultAlertDialog(
                      context, 'Would you like to delete?', pathToremove);
                },
                // Add more details as needed
              );
            },
          );
        }
      },
    );
  }
}
