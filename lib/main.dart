import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetectionScreen extends StatefulWidget {
  @override
  _DetectionScreenState createState() => _DetectionScreenState();
}

class _DetectionScreenState extends State<DetectionScreen> {
  List<double> confidenceList = [];
  bool isLoading = false;

  Future<void> fetchDetectionData() async {
    setState(() {
      isLoading = true;
      confidenceList = []; // 새 요청 시 초기화
    });

    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:5000/run'));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final detections = jsonData['detection'];

        setState(() {
          confidenceList = detections
              .map<double>((item) => item['confidence'] as double)
              .toList();
        });
      } else {
        throw Exception('Failed to load detection data');
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detection Result')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(onPressed: fetchDetectionData, child: Text('분석 시작')),
            const SizedBox(height: 20),
            if (isLoading)
              CircularProgressIndicator()
            else if (confidenceList.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: confidenceList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.check_circle_outline),
                      title: Text('Detection ${index + 1}'),
                      subtitle: Text(
                        'Confidence: ${confidenceList[index].toStringAsFixed(2)}',
                      ),
                    );
                  },
                ),
              )
            else
              Text('아직 분석 결과가 없습니다.'),
          ],
        ),
      ),
    );
  }
}

// no need to show detected box image
