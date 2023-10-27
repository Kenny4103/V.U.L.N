import 'package:flutter/material.dart';
import 'package:vuln/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Drawer Example',
      theme: ThemeData(
          colorScheme: const ColorScheme.highContrastDark(),
          primarySwatch: Colors.red,
          appBarTheme: const AppBarTheme(
              centerTitle: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50))))),
      home: const HomePage(),
    );
  }
}
