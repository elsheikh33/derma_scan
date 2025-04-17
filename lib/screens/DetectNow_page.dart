import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetectNow_page extends StatefulWidget {
  static const String id = 'DetectNow_page';

  final String detectedDisease;
  final Map<String, String?> userInputs;
  final File? uploadedImage;
  final String? annotatedImageBase64;


  const DetectNow_page({
    super.key,
    required this.detectedDisease,
    required this.userInputs,
    required this.uploadedImage,
    required this.annotatedImageBase64,
  });

  @override
  State<DetectNow_page> createState() => _DetectNowPageState();
}

class _DetectNowPageState extends State<DetectNow_page> {
  String? responseText;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchReportFromGPT();
  }

  Future<void> _fetchReportFromGPT() async {
    const apiKey = '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';
    final Uri url = Uri.parse('https://api.openai.com/v1/chat/completions');

    final prompt = '''
A user has been detected with: ${widget.detectedDisease}
Details:
- Symptom: ${widget.userInputs['symptom']}
- Duration: ${widget.userInputs['duration']}
- Itchiness: ${widget.userInputs['itchiness']}
- Pain level: ${widget.userInputs['painLevel']}
- Progress: ${widget.userInputs['progress']}

Now write a full detection report acting like a dermatologist that includes:
1. Description of the condition.
2. Suggested Remedies categorized into:
   - Critical
   - Non-Critical
3. Precautions until doctor visit.   


Structure with clear titles and avoid markdown formatting.
and don't write the word(detection report) at the beginning 
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
        String result = data['choices'][0]['message']['content'];
        result = result.replaceAll('**', ''); // clean markdown

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
        title: Text(
          "${widget.detectedDisease[0].toUpperCase()}${widget.detectedDisease.substring(1)} Detected!",
        ),
        backgroundColor: Color(0xFF8E97FD),
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              'Generating your skin report...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      )
          : SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.annotatedImageBase64 != null && widget.annotatedImageBase64!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.memory(
                  base64Decode(widget.annotatedImageBase64!),
                  height: 350,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              )
            else
              const Text(
                'No annotated image available',
                style: TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 20),
            Text(
              responseText ?? 'No data available',
              style: const TextStyle(
                fontSize: 16,
                height: 1.6,
                color: Colors.black87,
                fontFamily: 'Roboto',
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'Locator_page');
                },
                icon: Icon(Icons.place, color: Colors.white),
                label: Text(
                  'Find Nearest Clinic',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF8E97FD),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
