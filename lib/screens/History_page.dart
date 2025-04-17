import 'dart:convert';
import 'package:flutter/material.dart';
//import 'DetectionReportPage.dart'; // we'll create this next

class HistoryPage extends StatelessWidget {
  static const String id = 'History_page';

  final List<Map<String, dynamic>> dummyHistory = [
    {
      'disease': 'Eczema',
      'date': '2025-04-10',
      'imageBase64': '', // placeholder (optional for now)
      'report': 'Eczema is a skin condition that causes inflammation. Critical: Use corticosteroid cream. Non-Critical: Moisturize regularly. Avoid hot showers.'
    },
    {
      'disease': 'Acne',
      'date': '2025-03-22',
      'imageBase64': '',
      'report': 'Acne is caused by clogged pores. Critical: Use prescribed topical treatments. Non-Critical: Avoid oily products. Maintain face hygiene.'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text("History"),
        backgroundColor: Color(0xFF8E97FD),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: dummyHistory.length,
        itemBuilder: (context, index) {
          final item = dummyHistory[index];

          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.grey[300],
                    child: Text(
                      item['disease'][0],
                      style: TextStyle(fontSize: 24, color: Colors.black54),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item['disease'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(item['date'], style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       // MaterialPageRoute(
                  //       //   builder: (_) => DetectionReportPage(
                  //       //     disease: item['disease'],
                  //       //     date: item['date'],
                  //       //     imageBase64: item['imageBase64'],
                  //       //     report: item['report'],
                  //       //   ),
                  //       // ),
                  //     );
                  //   },
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: Color(0xFF8E97FD),
                  //     foregroundColor: Colors.white,
                  //   ),
                  //   child: Text("View"),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
