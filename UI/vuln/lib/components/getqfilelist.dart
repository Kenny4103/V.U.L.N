import 'package:flutter/material.dart';
import 'package:vuln/services/getquarantined.dart';

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

  @override
  Widget build(BuildContext context) {
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
                // Add more details as needed
              );
            },
          );
        }
      },
    );
  }
}
