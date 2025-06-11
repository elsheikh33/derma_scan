import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grad/Constants/Colors.dart';
import 'package:provider/provider.dart';

import '../config/Provider/auth_provider.dart';
import '../model/detection_history.dart';

class HistoryPage extends StatefulWidget {
  static const String id = "History_page";

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late Future<List<DetectionHistory>> _historyFuture;
  late TextEditingController usernameController;

  @override
  void initState() {
    super.initState();
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    _historyFuture = authProvider.getDetectionHistory();
    usernameController = TextEditingController(
        text: authProvider.userDetails?.username);
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    String username = authProvider.userDetails?.username ?? "User";

    return Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
    body: RefreshIndicator(
    onRefresh: () async {
    setState(() {
    _historyFuture = Provider.of<AuthProvider>(context, listen: false)
        .getDetectionHistory();
    });
    },
    child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'DERMA',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    Image.asset('assets/logo.png'),
                    const Text(
                      'SCAN',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  Text(
                    '$username\'s History',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 4),
              child: Row(
                children: [
                  Text(
                    'VIEW YOUR PREVIOUS DETECTIONS',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25,vertical:4 ),
              child: Row(
                children: [
                    ElevatedButton(
                      onPressed: () => setState(() {
                        _historyFuture = Provider.of<AuthProvider>(context, listen: false)
                            .getDetectionHistory();
                      }),
                      child: Text('Refresh'),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<DetectionHistory>>(
                future: _historyFuture,
                builder: (context, snapshot) {
                  // Add debug prints
                  print('Snapshot state: ${snapshot.connectionState}');
                  print('Snapshot data: ${snapshot.data}');
                  print('Snapshot error: ${snapshot.error}');

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Error loading history'),
                          Text(snapshot.error.toString()),
                        ],
                      ),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('No detection history found'),
                        ],
                      ),
                    );
                  }

                  final detections = snapshot.data!;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.builder(
                      itemCount: detections.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.65,
                      ),
                      itemBuilder: (context, index) {
                        final item = detections[index];
                        final formattedDate = '${item.date.day}/${item.date.month}/${item.date.year}';

                        return Container(
                          decoration: BoxDecoration(
                            color: _getColorForIndex(index),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Expanded(
                          child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: item.imageBase64 != null && item.imageBase64!.isNotEmpty
                              ? Image.memory(
                            base64Decode(item.imageBase64!),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (ctx, error, stack) => _buildPlaceholder(), // Fallback on error
                          )
                              : _buildPlaceholder(), // Fallback if null/empty
                        ),
                        ),

                              const SizedBox(height: 8),
                              Text(
                                item.disease,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                formattedDate,
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(height: 8),
                              Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                  onPressed: () {
                                    _showDetailsDialog(context, item);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    textStyle: const TextStyle(fontSize: 14),
                                  ),
                                  child: const Text("View"),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }

  Color _getColorForIndex(int index) {
    final colors = [
      Color(0xFF8E97FD),
      Color(0xFFFFC288),
      Color(0xFFA8D8EA),
      Color(0xFFAA96DA),
    ];
    return colors[index % colors.length];
  }

  void _showDetailsDialog(BuildContext context, DetectionHistory item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(item.disease),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (item.imageBase64 != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Image.memory(base64Decode(item.imageBase64!)),
                ),
              Text(
                item.description,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Detection Details:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ...item.userInputs.entries.map((e) =>
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text('${e.key}: ${e.value ?? "Not specified"}'),
                  )
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
  DateTime _parseFirestoreDate(dynamic date) {
    if (date is Timestamp) { // Handle Firestore Timestamp
      return date.toDate();
    } else if (date is String) { // Handle ISO string (from toIso8601String())
      return DateTime.parse(date);
    }
    return DateTime.now(); // Fallback
  }
  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey[200],
      child: Center(
        child: Icon(Icons.image, size: 50, color: Colors.grey[400]),
      ),
    );
  }
}


