import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vuln/components/drawer_view.dart';
import 'package:vuln/components/themeprovider.dart';
//import 'package:vuln/components/scan_now.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title:
            const Center(child: Text('Vulnerabilities Under Learned Network')),
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BackgroundDropdown(),
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

class _DropdownExampleState extends State<BackgroundDropdown> {
  String selectedValue = 'Dark'; // Default selected value

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 200,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withAlpha(170),
              borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: DropdownButton<String>(
              value: selectedValue,
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
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Background Color: $selectedValue',
          style: TextStyle(
              color: Theme.of(context).hintColor,
              backgroundColor: Theme.of(context).primaryColor),
        ),
      ],
    );
  }
}
