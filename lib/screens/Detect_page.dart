import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class DetectPage extends StatefulWidget {
  static const String id = 'Detect_page';
  @override
  _DetectPageState createState() => _DetectPageState();
}

class _DetectPageState extends State<DetectPage> {
  String? symptom;
  String? duration;
  String? itchiness;
  String? painLevel;
  String? progress;
  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8E97FD),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/profilePic.jpeg'), // Add this asset
                    radius: 25,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'semo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Title
              Text(
                'Answer the following questions to help us give you a precise report',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              // DropDown 1 - Symptoms
              _buildDropdown(
                label: 'What symptoms are you experiencing?',
                value: symptom,
                items: ['Redness', 'Swelling', 'Itchiness', 'Pain'],
                onChanged: (value) => setState(() => symptom = value),
              ),
              SizedBox(height: 20),
              // DropDown 2 - Duration
              _buildDropdown(
                label: 'How long have you been experiencing these symptoms?',
                value: duration,
                items: ['1-3 days', '1 week', '2 weeks', 'More than a month'],
                onChanged: (value) => setState(() => duration = value),
              ),
              SizedBox(height: 20),
              // DropDown 3 - Itchiness
              _buildDropdown(
                label: 'Is there itchiness?',
                value: itchiness,
                items: ['Yes', 'No'],
                onChanged: (value) => setState(() => itchiness = value),
              ),
              SizedBox(height: 20),
              // DropDown 4 - Pain Level
              _buildDropdown(
                label: 'Pain level [1-10]',
                value: painLevel,
                items: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
                onChanged: (value) => setState(() => painLevel = value),
              ),
              SizedBox(height: 20),
              // DropDown 5 - Progression
              _buildDropdown(
                label: 'Is it progressive or regressive?',
                value: progress,
                items: ['Progressive', 'Regressive'],
                onChanged: (value) => setState(() => progress = value),
              ),
              SizedBox(height: 20),
              // Image Picker
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.image, color: Colors.grey, size: 50),
                      SizedBox(height: 10),
                      Text(
                        _image == null
                            ? 'Choose from photos'
                            : 'Photo Selected',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              // Detect Now Button
              ElevatedButton(
                onPressed: () {
                  // Implement Detection Logic Here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: Size(double.infinity, 60),
                ),
                child: Text(
                  'DETECT NOW',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Dropdown Builder Method
  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(label, style: TextStyle(color: Colors.grey)),
          icon: Icon(Icons.arrow_drop_down, color: Colors.grey),
          isExpanded: true,
          onChanged: onChanged,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
        ),
      ),
    );
  }
}
