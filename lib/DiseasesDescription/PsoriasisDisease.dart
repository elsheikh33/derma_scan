import 'package:flutter/material.dart';

class PsoriasisPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Psoriasis'),
        backgroundColor: Color(0xFF8E97FD),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/Psoriasisimage.png', // Make sure this image is in your assets folder
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              'Psoriasis',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Psoriasis is a chronic skin condition that speeds up the life cycle of skin cells. It causes cells to build up rapidly on the surface of the skin, leading to scaly patches that are often itchy and sometimes painful.',
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
              '• Red patches of skin covered with thick, silvery scales\n'
                  '• Dry, cracked skin that may bleed\n'
                  '• Itching, burning, or soreness\n'
                  '• Thickened, pitted, or ridged nails\n'
                  '• Swollen and stiff joints (in psoriatic arthritis)',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Types',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'There are several types of psoriasis, including:\n'
                  '1. Plaque Psoriasis\n'
                  '2. Guttate Psoriasis\n'
                  '3. Inverse Psoriasis\n'
                  '4. Pustular Psoriasis\n'
                  '5. Erythrodermic Psoriasis',
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
              'While there is no cure for psoriasis, treatments can help manage symptoms. These may include topical treatments, light therapy, and systemic medications.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
