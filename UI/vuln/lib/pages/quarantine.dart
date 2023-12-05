import 'package:flutter/material.dart';
import 'package:vuln/components/drawer_view.dart';
import 'package:vuln/components/getqfilelist.dart';
//import 'package:vuln/components/scan_now.dart';

class QPage extends StatefulWidget {
  const QPage({super.key});

  @override
  State<QPage> createState() => _QPageState();
}

class _QPageState extends State<QPage> {
  String selectedFile = '';
  List<String> tempFiles = [];
  List<String> recentFiles = ['File 1', 'File 2', 'File 3', 'File 4'];
  List<String> fullListFiles = ['File A', 'File B', 'File C', 'File D'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Center(
          child: Text('Vulnerabilities Under Learned Network'),
        ),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: Container(
                width: 600,
                height: 400,
                decoration: BoxDecoration(
                  color: Theme.of(context).secondaryHeaderColor,
                  border: Border.all(),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Quarantine:',
                          style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).canvasColor),
                        )
                        // TabButton(
                        //   text: 'Recent',
                        //   onPressed: () {
                        //     showRecentFileList(recentFiles);
                        //   },
                        // ),
                        // TabButton(
                        //   text: 'Full List',
                        //   onPressed: () {
                        //     showFileList(fullListFiles);
                        //   },
                        // ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SearchBar(hint: Theme.of(context).hintColor),
                    const SizedBox(height: 10),
                    Expanded(
                      child: QuarantinedFilesList(),
                    ),
                    const SizedBox(height: 10),
                    Text('Selected File: $selectedFile'),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Version 1.0 File Select",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showFileList(List<String> files) {
    setState(() {
      tempFiles = recentFiles;
      recentFiles = files;
    });
  }

  void showRecentFileList(List<String> files) {
    setState(() {
      recentFiles = tempFiles;
    });
  }
}

class TabButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const TabButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key, required this.hint});
  final Color hint;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: TextStyle(color: hint),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
