import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetectNow_page extends StatefulWidget {
  static const String id = 'DetectNow_page';

  final String detectedDisease;
  final Map<String, String?> userInputs;

  const DetectNow_page({
    super.key,
    required this.detectedDisease,
    required this.userInputs,
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

  // Map disease name to image asset path
  String _getImageForDisease(String disease) {
    final diseaseImageMap = {
      'eczema': 'assets/eczemaImage.png',
      'psoriasis': 'assets/PsoriasisImage.png',
      'acne': 'assets/acneImage.png',
      'vitiligo': 'assets/VitiligoImage.png',
      'dermatitis': 'assets/atopic_dermatitis.png',
      'warts': 'assets/wartsImage.png',
      'urticaria': 'assets/UrticariaImage.png',
      'bruise': 'assets/BruiseImage.png',
      'herpes zoster': 'assets/herpsIamge.png',
      'basal cell': 'assets/BasalCellCarcinomaImage.png',
      'melanoma': 'assets/melanomaImage.png',
    };

    final key = disease.toLowerCase().trim();
    return diseaseImageMap[key] ?? 'assets/default.png';
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
    final imagePath = _getImageForDisease(widget.detectedDisease);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("${widget.detectedDisease[0].toUpperCase()}${widget.detectedDisease.substring(1)} Detected!"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                imagePath,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              responseText ?? 'No data available',
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
