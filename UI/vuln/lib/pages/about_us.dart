import 'package:flutter/material.dart';
import 'package:vuln/components/drawer_view.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

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
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: const AssetImage('assets/images/honeycomb.jpg'),
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.95),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16.0),
              ),
              constraints: const BoxConstraints(maxWidth: 600.0),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to our world of cybersecurity, where passion meets protection! '
                    'At VULN, we are driven by an unyielding commitment to securing the digital landscape and safeguarding the online realms we inhabit.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  // Add more Text widgets for other sections of the content
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
