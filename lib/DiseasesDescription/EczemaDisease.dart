import 'package:flutter/material.dart';

class EczemaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eczema'),
        backgroundColor: Color(0xFF8E97FD),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/Eczemaimage.png', // Make sure this image is in your assets folder
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              'Eczema (Atopic Dermatitis)',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Eczema, also known as atopic dermatitis, is a chronic skin condition that causes red, itchy, and inflamed patches of skin. It is commonly found in children but can occur at any age. Eczema is long-lasting and tends to flare periodically.',
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
              '• Dry, sensitive skin\n'
                  '• Red, inflamed skin\n'
                  '• Severe itching\n'
                  '• Dark-colored patches of skin\n'
                  '• Rough, leathery, or scaly patches\n'
                  '• Oozing or crusting\n'
                  '• Swelling',
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
              'The exact cause of eczema is unknown, but it is believed to be linked to an overactive immune system response to irritants. Genetic and environmental factors also play a role.',
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
              'Treatment includes moisturizing the skin, using anti-inflammatory medications, and avoiding triggers. In severe cases, oral medications or light therapy may be prescribed.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
