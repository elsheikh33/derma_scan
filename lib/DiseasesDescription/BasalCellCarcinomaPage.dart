import 'package:flutter/material.dart';

class BasalCellCarcinomaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Basal Cell Carcinoma'),
        backgroundColor: Color(0xFF8E97FD),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/BasalCellCarcinomaImage.png',
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              'Basal Cell Carcinoma (BCC)',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Basal Cell Carcinoma is the most common type of skin cancer. It arises from basal cells in the skin’s outermost layer and is typically caused by prolonged exposure to ultraviolet (UV) radiation from the sun or tanning beds. BCC rarely spreads to other parts of the body but can grow deeply and cause local damage.',
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
              '• A pearly or waxy bump\n'
                  '• A flat, flesh-colored or brown scar-like lesion\n'
                  '• A bleeding or scabbing sore that heals and returns\n'
                  '• A shiny pink or red, slightly scaly patch\n'
                  '• A white, yellow, or waxy area with poorly defined borders',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Causes & Risk Factors',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'The primary cause is long-term UV radiation exposure. Risk factors include fair skin, age over 50, a history of sunburns, use of tanning beds, and a weakened immune system.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Treatment Options',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Treatment depends on size, location, and depth of the tumor. Options include surgical excision, Mohs surgery, cryotherapy, topical medications, radiation therapy, or laser treatment. Early detection significantly improves outcomes.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
