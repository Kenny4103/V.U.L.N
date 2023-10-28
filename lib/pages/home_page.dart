// home_page.dart
import 'package:flutter/material.dart';
import 'package:vuln/components/drawer_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
