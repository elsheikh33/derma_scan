import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grad/screens/Home_page.dart';
import 'package:grad/screens/Login_page.dart';
import 'package:grad/screens/Main_page.dart';
import 'package:grad/screens/Signup_page.dart';
import 'package:grad/screens/Welcome_page.dart';

import 'Controller/dependency_injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  DependecyInjection().init();

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
        });
  }
}
