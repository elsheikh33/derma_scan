import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grad/screens/Home_page.dart';
import 'package:grad/screens/Login_page.dart';
import 'package:grad/screens/Main_page.dart';
import 'package:grad/screens/Signup_page.dart';
import 'package:grad/screens/Welcome_page.dart';

import 'config/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyDL7IHHpPSRQYMNv_sS1VjEXuqj21krHl0",
        appId: '1:387242201034:android:fbcc31c38a436adb3ec933',
        messagingSenderId: '387242201034',
        projectId: "grad-2ac70",
      ),
    );

    DependecyInjection().init(); // Initialize dependencies after Firebase

    runApp(const MyApp());
  } catch (e) {
    print("🔥 Firebase Initialization Error: $e");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomePage.id,
      routes: {
        HomePage.id: (conext) => HomePage(),
        SignupPage.id: (context) => SignupPage(),
        LoginPage.id: (context) => LoginPage(),
        WelcomePage.id: (context) => WelcomePage(),
        MainPage.id: (context) => MainPage(),
      }
    );
  }
}
