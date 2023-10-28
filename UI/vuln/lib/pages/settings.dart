import 'package:flutter/material.dart';
import 'package:vuln/components/drawer_view.dart';
//import 'package:vuln/components/scan_now.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
            //color: Colors.amber,
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
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Version 1.0 Settings",
                style: TextStyle(color: Colors.white),
              ),
            ],
          )),
    );
  }
}
