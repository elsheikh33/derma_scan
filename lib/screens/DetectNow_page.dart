import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetectNowPage extends StatefulWidget {
  static const String id = 'DetectNow_page';
  //const DetectNowPage({super.key});
  final String detectedDisease;
  final Map<String, String?> userInputs;

  const DetectNowPage({
    super.key,
    required this.detectedDisease,
    required this.userInputs,
  });

  @override
  State<DetectNowPage> createState() => _DetectNowPageState();
}

class _DetectNowPageState extends State<DetectNowPage> {
  String? responseText;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchReportFromGPT();
  }

  Future<void> _fetchReportFromGPT() async {
    const apiKey = 'YOUR_OPENAI_API_KEY'; // replace safely
    final Uri url = Uri.parse('https://api.openai.com/v1/chat/completions');

    final prompt = '''
A user has been detected with: ${widget.detectedDisease}
Details:
- Symptom: ${widget.userInputs['symptom']}
- Duration: ${widget.userInputs['duration']}
- Itchiness: ${widget.userInputs['itchiness']}
- Pain level: ${widget.userInputs['painLevel']}
- Progress: ${widget.userInputs['progress']}

Now write a full detection report that includes:
1. Description of the condition.
2. Precautions until doctor visit.
3. Suggested Remedies categorized into:
   - Critical
   - Non-Critical

Structure with clear titles and avoid markdown formatting.
''';

    try {
      final res = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-4-turbo',
          'messages': [
            {'role': 'user', 'content': prompt}
          ],
          'max_tokens': 2000,
        }),
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final result = data['choices'][0]['message']['content'];
        setState(() {
          responseText = result;
          isLoading = false;
        });
      } else {
        setState(() {
          responseText = 'Failed to fetch report.';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        responseText = 'Error: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Eczema Detected!"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Text(
          responseText ?? 'No data available',
          style: const TextStyle(fontSize: 16, height: 1.5),
        ),
      ),
    );
  }
}
