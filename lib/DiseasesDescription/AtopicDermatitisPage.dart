import 'package:flutter/material.dart';

class AtopicDermatitisPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Atopic Dermatitis'),
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
              'Atopic Dermatitis',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Atopic Dermatitis is a chronic skin condition characterized by dry, itchy, and inflamed skin. It is most common in children but can persist into adulthood. The condition often runs in families and is associated with allergies, asthma, or hay fever.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Common Symptoms',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '• Intense itching\n'
                  '• Red to brownish-gray patches\n'
                  '• Small raised bumps that may leak fluid\n'
                  '• Thickened, cracked, or scaly skin\n'
                  '• Raw or sensitive skin from scratching',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Triggers & Causes',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Triggers include allergens, harsh soaps, stress, weather changes, and sweating. The condition is linked to genetic mutations that affect the skin\'s barrier function, allowing moisture out and germs in.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Management & Treatment',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Treatment focuses on relieving symptoms. It includes daily moisturizing, topical corticosteroids, avoiding known triggers, and using antihistamines or immunosuppressants in severe cases. Consistency in skincare is key.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
