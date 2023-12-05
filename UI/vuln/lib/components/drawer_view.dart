import 'package:flutter/material.dart';
import 'package:vuln/pages/about_us.dart';
import 'package:vuln/pages/file_select.dart';
import 'package:vuln/pages/home_page.dart';
import 'package:vuln/pages/quarantine.dart';
import 'package:vuln/pages/scanner_page.dart';
import 'package:vuln/pages/settings.dart';
import 'package:vuln/pages/support_page.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.grey[900],
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 120.0,
              child: DrawerHeader(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/vulnback.jpeg'),
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'VULN',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            _createDrawerItem(
              context,
              icon: Icons.home,
              text: 'Home',
              onTap: () => _navigateTo(context, const HomePage()),
            ),
            _createDrawerItem(
              context,
              icon: Icons.security,
              text: 'Scanner',
              onTap: () => _navigateTo(context, const ScannerPage()),
            ),
            _createDrawerItem(
              context,
              icon: Icons.folder_open,
              text: 'File Select',
              onTap: () => _navigateTo(context, const FileSPage()),
            ),
            _createDrawerItem(
              context,
              icon: Icons.delete_outline,
              text: 'Quarantine',
              onTap: () => _navigateTo(context, const QPage()),
            ),
            _createDrawerItem(
              context,
              icon: Icons.settings,
              text: 'Settings',
              onTap: () => _navigateTo(context, const SettingsPage()),
            ),
            _createDrawerItem(
              context,
              icon: Icons.info_outline,
              text: 'About Us',
              onTap: () => _navigateTo(context, const AboutPage()),
            ),
            _createDrawerItem(
              context,
              icon: Icons.contact_support_outlined,
              text: 'Support',
              onTap: () => _navigateTo(context, const SupportPage()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createDrawerItem(BuildContext context, {required IconData icon, required String text, VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(text, style: TextStyle(color: Colors.white)),
      onTap: () {
        Navigator.pop(context); // Close the drawer before navigating
        onTap?.call();
      },
    );
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
  }
}
