import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grad/DiseasesDescription/AcneDisease.dart';
import 'package:grad/DiseasesDescription/EczemaDisease.dart';
import 'package:grad/DiseasesDescription/HerpsDisease.dart';
import 'package:grad/DiseasesDescription/PsoriasisDisease.dart';
import 'package:grad/DiseasesDescription/urticariaDisease.dart';
import 'package:grad/DiseasesDescription/vitiligoDisease.dart';
import 'package:grad/DiseasesDescription/wartsDisease.dart';
import 'package:grad/screens/Detect_page.dart';
import 'package:grad/screens/Home_page.dart';
import 'package:grad/screens/Login_page.dart';
import 'package:grad/screens/Main_page.dart';
import 'package:grad/screens/Profile_page.dart';
import 'package:grad/screens/Signup_page.dart';
import 'package:grad/screens/Splash_screen.dart';
import 'package:grad/screens/Welcome_page.dart';
import 'package:provider/provider.dart';
import 'Controller/dependency_injection.dart';
import 'DiseasesDescription/AtopicDermatitisPage.dart';
import 'DiseasesDescription/BasalCellCarcinomaPage.dart';
import 'DiseasesDescription/BruisePage.dart';
import 'DiseasesDescription/MelanomaPage.dart';
import 'config/Provider/auth_provider.dart';


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

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
        ],
        child: MyApp(),
      ),
    );
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

      routes: {
        '/': (context) => const SplashScreen(),
        HomePage.id: (context) => HomePage(),
        SignupPage.id: (context) => SignupPage(),
        LoginPage.id: (context) => LoginPage(),
        WelcomePage.id: (context) => WelcomePage(),
        MainPage.id: (context) => MainPage(),
        ProfilePage.id:(context) => ProfilePage(),
        DetectPage.id:(context)=>DetectPage(),
        //DetectNow_page.id:(context)=>DetectNow_page(),
        'herpes_zoster': (context) => HerpesPage(),
        'acne': (context) => AcnePage(),
        'psoriasis': (context) => PsoriasisPage(),
        'bruise':(context)=>BruisePage(),
        'eczema': (context) => EczemaPage(),
        'warts': (context) => WartsPage(),
        'urticaria': (context) => UrticariaPage(),
        'vitiligo': (context) => VitiligoPage(),
        'atopic_dermatitis': (context) => AtopicDermatitisPage(),
        'basal_cell_carcinoma': (context) => BasalCellCarcinomaPage(),
        'melanoma': (context) => MelanomaPage(),
      }
    );
  }
}
