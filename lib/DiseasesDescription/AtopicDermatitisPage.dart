import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/Provider/language_provider.dart';

class AtopicDermatitisPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text(lan.getTexts("ad_title")),
        backgroundColor: Color(0xFF8E97FD),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/atopic_dermatitis.png',
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              lan.getTexts("ad_title"),
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              lan.getTexts("ad_description"),
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              lan.getTexts("ad_symptoms_title"),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              lan.getTexts("ad_symptoms"),
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              lan.getTexts("ad_causes_title"),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              lan.getTexts("ad_causes"),
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              lan.getTexts("ad_treatment_title"),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              lan.getTexts("ad_treatment"),
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}