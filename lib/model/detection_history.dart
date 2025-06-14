import 'package:cloud_firestore/cloud_firestore.dart';

class DetectionHistory {
  final String disease;
  final String description;
  final DateTime date; // Changed from String to DateTime
  final String? imageBase64;
  final Map<String, String?> userInputs;

  DetectionHistory({
    required this.disease,
    required this.description,
    required this.date, // Now accepts DateTime
    this.imageBase64,
    required this.userInputs,
  });

  Map<String, dynamic> toMap() {
    return {
      'disease': disease,
      'description': description,
      'date': Timestamp.fromDate(date), // Convert to Firestore Timestamp
      'imageBase64': imageBase64,
      'userInputs': userInputs,
    };
  }

  factory DetectionHistory.fromMap(Map<String, dynamic> map) {
    return DetectionHistory(
      disease: map['disease'] ?? '',
      description: map['description'] ?? '',
      date: _parseDate(map['date']), // Use helper function
      imageBase64: map['imageBase64'],
      userInputs: Map<String, String?>.from(map['userInputs'] ?? {}),
    );
  }

  static DateTime _parseDate(dynamic date) {
    if (date is Timestamp) {
      return date.toDate();
    } else if (date is String) {
      return DateTime.parse(date);
    }
    return DateTime.now();
  }
}