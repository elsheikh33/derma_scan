import 'package:flutter/material.dart';

class MelanomaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Melanoma'),
        backgroundColor: Color(0xFF8E97FD),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/melanomaImage.png',
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              'Melanoma',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Melanoma is a serious form of skin cancer that develops in the melanocytes — the cells responsible for producing pigment (melanin). It is more likely to grow and spread than other types of skin cancer, making early detection and treatment critical.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Warning Signs (ABCDE Rule)',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '• **A**symmetry: One half is unlike the other\n'
                  '• **B**order: Irregular, scalloped, or poorly defined border\n'
                  '• **C**olor: Varies from one area to another\n'
                  '• **D**iameter: Usually greater than 6 mm (pencil eraser size)\n'
                  '• **E**volving: Changes in size, shape, or color over time',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Risk Factors',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Risk factors include excessive UV exposure, fair skin, a family or personal history of melanoma, many moles, and weakened immune function.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Diagnosis & Treatment',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Diagnosis involves skin examination and biopsy. Treatment depends on the stage and may include surgical removal, immunotherapy, targeted therapy, chemotherapy, or radiation. When detected early, melanoma is highly treatable.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
