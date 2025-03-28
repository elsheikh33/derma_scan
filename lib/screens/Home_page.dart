
import 'package:flutter/material.dart';

import '../Constants/Colors.dart';
import '../Constants/Design.dart';
import 'Login_page.dart';
import 'Signup_page.dart';

class HomePage extends StatelessWidget {
  static const String id = "Home_page";
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Center(
                child: Hero(
                  tag: 'logo',
                  child: SizedBox(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'DERMA',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        Image.asset('assets/logoo.png',width: 20,height: 20,),
                        const Text(
                          'SCAN',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/HomeScreen.png',
              width: w,
              height: h * 0.55,
              fit: BoxFit.cover,
            ),
            const Center(child: Text('Your Skin , Our Science',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 22),)),
            const SizedBox(height: 5),
            const Center(child: Text('Thousand of people are using DermaScan\n                   for Skin Detection',style: TextStyle(color: Colors.grey,),)),
            const SizedBox(height: 5),
            customButton(
                text: 'Sign Up',
                color: AppColor.mainColor,
                txtcolor: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, SignupPage.id);
                },
                context: context
            ),
            const SizedBox(height: 5),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "ALREADY HAVE AN ACCOUNT? ",
                  style: TextStyle(
                    color: Colors.black, // Normal text color
                    fontSize: 12,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, LoginPage.id);
                  },
                  child: const Text(
                    "LOG IN",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
