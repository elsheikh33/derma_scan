import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../config/Provider/language_provider.dart';
import 'DetectNow_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



import 'package:provider/provider.dart';

import '../config/Provider/auth_provider.dart';

class DetectPage extends StatefulWidget {
  static const String id = 'Detect_page';
  const DetectPage({super.key});

  @override
  State<DetectPage> createState() => _DetectPageState();
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

  Future<Map<String, dynamic>?> detectDisease(File imageFile) async {
    //final uri = Uri.parse('https://553b-35-231-181-48.ngrok-free.app/detect/');//link public colab
    final uri = Uri.parse('http://192.168.100.103:8000/detect/'); //link locally
    final request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final response = await request.send();
    final responseData = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final result = jsonDecode(responseData);
      return {
        'disease': result['disease'],
        'imageBase64': result['image']
      };
    } else {
      print('❌ Failed to detect: ${response.statusCode}');
      return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    final username = authProvider.userDetails?.username ?? "User";
    var lan =Provider.of<LanguageProvider>(context, listen: true);

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
                    backgroundImage: AssetImage('assets/ProfilePic.png'), // Add this asset
                    radius: 18,
                  ),
                  SizedBox(width: 10),
                  Text(
                    '$username ${lan.getTexts("hi")}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              // Title
              Text(
                lan.getTexts("questionReport"),
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,),
              SizedBox(height: 10),
              // DropDown 1 - Symptoms
               Text(
                lan.getTexts("questionSymptom"),
                style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),
              ),
              _buildDropdown(
                label: '',
                value: symptom,
                items: [
                  lan.getTexts("rednessSymptom"),
                  lan.getTexts("swellingSymptom"),
                  lan.getTexts("ItchinessSymptom"),
                  lan.getTexts("PainSymptom"),
                ],
                onChanged: (value) => setState(() => symptom = value),
              ),
              SizedBox(height: 10),
              // DropDown 2 - Duration
               Text(
                 lan.getTexts("questionHowLong"),
                style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),
              ),
              _buildDropdown(
                label: '',
                value: duration,
                items: [
                  lan.getTexts("daysList"),
                  lan.getTexts("week1List"),
                  lan.getTexts("week2List"),
                  lan.getTexts("monthList"),],
                onChanged: (value) => setState(() => duration = value),
              ),
              SizedBox(height: 10),
              // DropDown 3 - Itchiness
               Text(
                lan.getTexts("questionItch"),
                style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),
              ),
              _buildDropdown(
                label: '',
                value: itchiness,
                items: [
                  lan.getTexts("Agree"),
                  lan.getTexts("Disagree")],
                onChanged: (value) => setState(() => itchiness = value),
              ),
              SizedBox(height: 10),
              // DropDown 4 - Pain Level
               Text(
                lan.getTexts("Pain level"),
                style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),
              ),
              _buildDropdown(
                label: '',
                value: painLevel,
                items: [
                  lan.getTexts("painList1"),
                  lan.getTexts("painList2"),
                  lan.getTexts("painList3"),
                  lan.getTexts("painList4"),
                  lan.getTexts("painList5"),
                  lan.getTexts("painList6"),
                  lan.getTexts("painList7"),
                  lan.getTexts("painList8"),
                  lan.getTexts("painList9"),
                  lan.getTexts("painList10")],
                onChanged: (value) => setState(() => painLevel = value),
              ),
              SizedBox(height: 10),
              // DropDown 5 - Progression
               Text(
                 lan.getTexts("question_progressive"),
                style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),
              ),
              _buildDropdown(
                label: '',
                value: progress,
                items: [
                  lan.getTexts("progressiveList"),
                  lan.getTexts("RegressiveList"),
                  lan.getTexts("UnchangeList"),
                ],
                onChanged: (value) => setState(() => progress = value),
              ),
              SizedBox(height: 10),
              // Image Picker
               Text(
                lan.getTexts("upload_photo"),
                style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),
              ),
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
                            ? lan.getTexts("choose_photo")
                            : lan.getTexts("selected_photo"),
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              Text(lan.getTexts("cameraNote"),style: TextStyle(fontSize: 11, color: Color(0XFF8B0000) ,fontWeight: FontWeight.bold,)),
              SizedBox(height: 20),
              // Detect Now Button
              ElevatedButton(
                onPressed: () async {
                  if (_image == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(lan.getTexts("snackBarNoteImg"))),
                    );
                    return;
                  }

                  final result = await detectDisease(_image!);
                  if (result == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(lan.getTexts("snackBarNoteDetect"))),
                    );
                    return;
                  }

                  final userInputs = {
                    'symptom': symptom,
                    'duration': duration,
                    'itchiness': itchiness,
                    'painLevel': painLevel,
                    'progress': progress,
                  };

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetectNow_page(
                        detectedDisease: result['disease'],
                        userInputs: userInputs,
                        uploadedImage: _image!, // ✅ add this
                        annotatedImageBase64: result['imageBase64'],
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: Size(double.infinity, 60),
                ),
                child: Text(
                  lan.getTexts("detect_button"),
                  style: TextStyle(
                    color: Colors.black,
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
          value: items.contains(value) ? value : null,
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