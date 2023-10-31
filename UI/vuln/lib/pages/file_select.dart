import 'package:flutter/material.dart';
import 'package:vuln/components/drawer_view.dart';
//import 'package:vuln/components/scan_now.dart';

class FileSPage extends StatefulWidget {
  const FileSPage({super.key});

  @override
  State<FileSPage> createState() => _FileSPageState();
}

class _FileSPageState extends State<FileSPage> {
  String selectedFile = '';
  List<String> tempFiles = [];
  List<String> recentFiles = ['File 1', 'File 2', 'File 3', 'File 4'];
  List<String> fullListFiles = ['File A', 'File B', 'File C', 'File D'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title:
            const Center(child: Text('Vulnerabilities Under Learned Network')),
      ),
      drawer: const DrawerView(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: const AssetImage('assets/images/honeycomb.jpg'),
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.95),
              BlendMode.dstATop,
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
                  color: Colors.black,
                  border: Border.all(),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TabButton(
                          text: 'Recent',
                          onPressed: () {
                            showRecentFileList(recentFiles);
                          },
                        ),
                        TabButton(
                          text: 'Full List',
                          onPressed: () {
                            showFileList(fullListFiles);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const SearchBar(),
                    const SizedBox(height: 10),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                            recentFiles.length,
                            (index) => ListTile(
                              title: Text(recentFiles[index]),
                              onTap: () {
                                setState(() {
                                  selectedFile = recentFiles[index];
                                });
                              },
                            ),
                          ),
                        ),
                      ),
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
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Search...',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
