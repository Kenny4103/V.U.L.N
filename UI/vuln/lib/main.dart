import 'package:flutter/material.dart';
import 'package:vuln/pages/home_page.dart';
import 'dart:io';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Check if the WINDOW_CONSTRAINTS environment variable is set
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    // Apply window size constraints
    applyWindowSizeConstraints();
  }
  runApp(const MyApp());
}

void applyWindowSizeConstraints() {
  // Use platform-specific code to set window size constraints
  // For Linux, you can use the `dart:ffi` library or platform channels
  // to interact with the native windowing system and set constraints.
  // Alternatively, you can use the `window_size` package.
  // Example (using `window_size` package):
  setWindowMinSize(const Size(500, 300));
  setWindowMaxSize(const Size(800, 600));
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
