import 'package:flutter/material.dart';

class AcnePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acne'),
        backgroundColor: Color(0xFF8E97FD),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/Acneimage.png', // Make sure this image is in your assets folder
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              'Acne',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Acne is a common skin condition that occurs when hair follicles become clogged with oil and dead skin cells. It can cause whiteheads, blackheads, or pimples. Acne is most common among teenagers, though it affects people of all ages.',
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
              '• Whiteheads (closed clogged pores)\n'
                  '• Blackheads (open clogged pores)\n'
                  '• Small red, tender bumps (papules)\n'
                  '• Pimples (pustules), which are papules with pus at their tips\n'
                  '• Large, solid, painful lumps beneath the skin (nodules)\n'
                  '• Painful, pus-filled lumps beneath the skin (cystic lesions)',
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
              'Four main factors cause acne:\n'
                  '1. Excess oil production\n'
                  '2. Hair follicles clogged by oil and dead skin cells\n'
                  '3. Bacteria\n'
                  '4. Inflammation',
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
              'Treatment for acne depends on its severity and can include over-the-counter topical treatments, prescription medications, and lifestyle changes.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
