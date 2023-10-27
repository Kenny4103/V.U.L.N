import 'dart:convert';
import 'dart:io';

Future<List<dynamic>> runPythonScript() async {
  const pythonScriptPath =
      'lib/services/scan.py'; // Adjust the path accordingly
  final process = await Process.start('python', [pythonScriptPath]);

  final output = await process.stdout.transform(utf8.decoder).join();
  final errorOutput = await process.stderr.transform(utf8.decoder).join();

  final exitCode = await process.exitCode;

  if (exitCode == 0) {
    return jsonDecode(output) as List<dynamic>;
  } else {
    return [
      {"status": "error", "error_message": errorOutput}
    ];
  }
}

void main() async {
  final result = await runPythonScript();

  print(result);

  // Now you can use the result to update your Flutter UI
}
