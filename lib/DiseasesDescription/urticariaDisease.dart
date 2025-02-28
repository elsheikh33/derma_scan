import 'package:flutter/material.dart';

class UrticariaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Urticaria'),
        backgroundColor: Color(0xFF8E97FD),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/Urticariaimage.png', // Make sure this image is in your assets folder
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              'Urticaria (Hives)',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Urticaria, commonly known as hives, is a skin reaction that causes itchy welts. These welts can vary in size and can appear anywhere on the body. They are often red, pink, or flesh-colored and can be painful or itchy.',
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
              '• Itchy, raised welts on the skin\n'
                  '• Welts that vary in size and shape\n'
                  '• Red, pink, or flesh-colored patches\n'
                  '• Swelling or inflammation\n'
                  '• Discomfort or pain',
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
              'Urticaria can be triggered by allergic reactions, stress, infections, or environmental factors such as temperature changes or sun exposure. In some cases, the cause may be unknown (idiopathic urticaria).',
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
              'Treatment may include antihistamines to relieve itching and swelling, avoiding known triggers, and using topical soothing agents. In severe cases, corticosteroids or other medications may be prescribed.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
