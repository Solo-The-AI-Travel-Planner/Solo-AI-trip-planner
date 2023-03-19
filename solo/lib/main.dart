import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter HTTP Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _outputData = '';

  void _makeHttpRequest() async {
    const serverUrl = 'http://localhost:5000'; // Replace with your Flask server URL
    final inputData = {'data': 'input_data'};
    final jsonInputData = json.encode(inputData);
    final notebookUrl = Uri.parse('https://colab.research.google.com/drive/1UQgfNnkx8oZ6FEIzyg91ndpz-BI0ixR7?usp=sharing');
    final response = await http.post(notebookUrl as Uri, body: jsonInputData);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final outputData = json.decode(response.body)['data'];
      setState(() {
        _outputData = outputData;
      });
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to get data from server.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter HTTP Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _makeHttpRequest,
              child: Text('Make HTTP Request'),
            ),
            SizedBox(height: 20),
            Text('Output Data: $_outputData'),
          ],
        ),
      ),
);
}
}