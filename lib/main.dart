import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<String> callPython() async {
    final response = await http.get(Uri.parse('http://localhost:5000/run'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['result'];
    } else {
      return 'ERROR: ${response.statusCode}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Flutter + Python')),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              String result = await callPython();
              showDialog(
                context: context,
                builder: (_) => AlertDialog(content: Text(result)),
              );
            },
            child: Text('Run Python'),
          ),
        ),
      ),
    );
  }
}
