import 'package:flutter/material.dart';

class CancerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Skin Cancer'),
        backgroundColor: Color(0xFF8E97FD),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/CancerDisease.png',
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              'Skin Cancer',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Skin cancer is the abnormal growth of skin cells, often developing on areas of the skin exposed to the sun. It includes different types such as basal cell carcinoma, squamous cell carcinoma, and melanoma. Early detection is crucial for successful treatment.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Symptoms',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '• A new growth or sore that doesn’t heal\n'
                  '• Changes in an existing mole\n'
                  '• A mole with irregular borders or multiple colors\n'
                  '• Itching, tenderness, or bleeding on a skin spot\n'
                  '• Flat, scaly patches that may be red or brown',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Causes',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Skin cancer is primarily caused by prolonged exposure to ultraviolet (UV) radiation from the sun or tanning beds. Risk factors include:\n'
                  '1. Fair skin\n'
                  '2. Excessive sun exposure\n'
                  '3. Family history of skin cancer\n'
                  '4. History of sunburns\n'
                  '5. Weakened immune system',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Treatment',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Treatment depends on the type and stage of cancer and may include surgical removal, radiation therapy, chemotherapy, or immunotherapy. Early-stage skin cancers are often treatable with outpatient procedures.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
