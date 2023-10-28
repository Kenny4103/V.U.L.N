<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:vuln/components/scan_now.dart';
=======
// home_page.dart
import 'package:flutter/material.dart';
import 'package:vuln/components/drawer_view.dart';
>>>>>>> dfd6c94 (added backgroun/button)

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
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
=======
        title: const Center(
          child: Text('Vulnerabilities Under Learned Network'),
        ),
      ),
      drawer: const DrawerView(),
      body: Stack(
        children: [
          // Include BackgroundVideo here
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
              image: DecorationImage(
                fit: BoxFit.contain,
                image: const AssetImage('assets/images/vulnback.jpeg'),
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.95),
                  BlendMode.dstATop,
                ),
              ),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Last Scanned: ",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Version 1.0 Home",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
>>>>>>> dfd6c94 (added backgroun/button)
