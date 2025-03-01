import 'package:flutter/material.dart';

class HerpesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Herpes Zoster'),
        backgroundColor: Color(0xFF8E97FD),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/Herpsimage.png',
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              'Herpes Zoster (Shingles)',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Herpes Zoster, also known as shingles, is a viral infection that causes a painful rash. It is caused by the varicella-zoster virus, the same virus that causes chickenpox. After recovering from chickenpox, the virus can lie dormant in nerve tissue and reactivate later as shingles.',
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
              '• Pain, burning, numbness, or tingling\n'
                  '• Sensitivity to touch\n'
                  '• Red rash that begins a few days after the pain\n'
                  '• Fluid-filled blisters that break open and crust over\n'
                  '• Itching',
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
              'Herpes Zoster is caused by the varicella-zoster virus. After a person has chickenpox, the virus remains dormant in the nervous system and can reactivate years later as shingles.',
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
              'Treatment may include antiviral medications, pain relievers, and topical ointments to alleviate symptoms. Vaccines are also available to reduce the risk of developing shingles.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

