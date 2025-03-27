import 'package:flutter/material.dart';

class BruisePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bruise'),
        backgroundColor: Color(0xFF8E97FD),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/Bruiseimage.png',
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              'Bruise (Contusion)',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'A bruise, or contusion, is a common skin injury that results in discoloration of the skin due to trauma or impact, which causes small blood vessels (capillaries) to break and leak under the skin.',
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
              '• Blue, black, or purple discoloration\n'
                  '• Tenderness or pain at the site\n'
                  '• Swelling around the area\n'
                  '• Color change over time (green, yellow, or brown as it heals)',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Common Causes',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Bruises are typically caused by bumps, falls, or blows to the body. They can also be a side effect of certain medications (like blood thinners) or indicate an underlying bleeding disorder.',
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
              'Most bruises heal on their own. Treatment includes:\n'
                  '• Resting the area\n'
                  '• Applying ice packs for 15-20 minutes\n'
                  '• Elevating the area to reduce swelling\n'
                  '• Taking over-the-counter pain relievers (if needed)',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
