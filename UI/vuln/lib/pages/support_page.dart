import 'package:flutter/material.dart';
import 'package:vuln/components/drawer_view.dart';
//import 'package:vuln/components/scan_now.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

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
            //color: Colors.amber,
            color: Colors.black,
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
              Text(
                "Version 1.0 Support",
                style: TextStyle(color: Colors.white),
              ),
            ],
          )),
    );
  }
}
