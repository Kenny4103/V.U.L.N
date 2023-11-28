import 'package:file_picker/file_picker.dart';
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
            Container(
              width: 600,
              height: 400,
              decoration: BoxDecoration(
                color: Theme.of(context).secondaryHeaderColor,
                border: Border.all(),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "To select a File press --> ",
                          style: TextStyle(fontSize: 20),
                        ),
                        ElevatedButton(
                          autofocus: true,
                          onPressed: () async {
                            // Open the file picker
                            FilePickerResult? result = await FilePicker.platform
                                .pickFiles(type: FileType.any);

                            if (result != null) {
                              // Handle the selected file or folder
                              String filePath = result.files.single.path!;
                              setState(() {
                                selectedFile = filePath;
                              });

                              print('Selected path: $filePath');
                            } else {
                              // User canceled the file picker
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("The file path you selected is: "),
                        Text(
                          selectedFile,
                          style: TextStyle(color: Theme.of(context).hintColor),
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Would you like to Scan?"),
                      ],
                    ),
                  )
                ],
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
