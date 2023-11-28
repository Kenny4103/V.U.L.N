import 'package:flutter/material.dart';
import 'package:vuln/components/drawer_view.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 100,
            ),
            const Text(
              "↓↓↓ Found an Issue? Please Report It Below ↓↓↓",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                maxLines: 5, // Adjust based on your requirement
                decoration: InputDecoration(
                  hintText: 'Enter your report here...',
                  hintStyle: TextStyle(color: Theme.of(context).indicatorColor),
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Make API call to send the report to the database
                // You can implement your API call logic here
              },
              child: const Text('Submit Report'),
            ),
            const SizedBox(
              height: 100,
            ),
            const Text(
              "Version 1.0 Support",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
