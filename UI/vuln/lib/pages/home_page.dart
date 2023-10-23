import 'package:flutter/material.dart';
import 'package:vuln/components/scan_now.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                // Add navigation logic if needed
              },
            ),
            ListTile(
              title: const Text('Scanner'),
              onTap: () {
                // Add navigation logic if needed
              },
            ),
            ListTile(
              title: const Text('File Select'),
              onTap: () {
                // Add navigation logic if needed
              },
            ),
            ListTile(
              title: const Text('Quarantine'),
              onTap: () {
                // Add navigation logic if needed
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                // Add navigation logic if needed
              },
            ),
            ListTile(
              title: const Text('About Us'),
              onTap: () {
                // Add navigation logic if needed
              },
            ),
            ListTile(
              title: const Text('Support'),
              onTap: () {
                // Add navigation logic if needed
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: NeonButt2("Scan Now"),
      ),
    );
  }
}