
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Constants/Colors.dart';
import '../Constants/Design.dart';
import '../config/Provider/auth_provider.dart';
import '../config/Provider/language_provider.dart';
import 'Signup_page.dart';


bool passwordVisibility = true;
TextEditingController emailController = TextEditingController();
TextEditingController passController = TextEditingController();

class LoginPage extends StatefulWidget {
  static const String id = "Login_page";
  const LoginPage({super.key});


  @override
  State<LoginPage> createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var lan =Provider.of<LanguageProvider>(context, listen: true);

    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [

                  BGImage(imageName: 'assets/BG1.png',top: 0,left: 0,),
                  Positioned(
                    top: 20,
                    left: 20,
                    child: CustomBackArrow(),
                  ),

                  // Top-right image
                  BGImage(imageName: 'assets/BG2.png',top: 0,right: 0,),

                  // Bottom-left image
                  BGImage(imageName: 'assets/BG4.png',bottom: 0, left: 0,),

                  // Bottom-right image
                  BGImage(imageName: 'assets/BG3.png',bottom: -5,right: 0,),
                  SizedBox(
                    width: w,
                    height: h * 0.40,
                    child:  Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text(
                          lan.getTexts("welcomeBack"),
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20), 
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 40, 
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: MaterialButton(
                            height: 50,
                              color: const Color(0xFF3758ff),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child:  Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(children: [
                                  Icon(Icons.facebook_rounded,color: Colors.white,),
                                  SizedBox(width: 30,),
                                  Text(lan.getTexts("ContWithFaceBook"),style: TextStyle(color: Colors.white),),
                                ],),
                              ),
                              
                              onPressed: () {
                                print('hello');
                              }),
                        ),
                      ),
                    ),
                  )
                ],
              ),

              // Form Fields
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                          height: 50,
                          color: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child:  Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(children: [
                              Image.asset('assets/Google.png'),
                              SizedBox(width: 30,),
                              Text(lan.getTexts("ContWithGoogle"),style: TextStyle(color: Colors.black),),
                            ],),
                          ),

                          onPressed: () {
                            print('hello');
                          }),
                    ),
                    SizedBox(height: 20,),
                    Center(child: Text(lan.getTexts("ContWithMail"),style: TextStyle(fontWeight: FontWeight.bold),),),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration:  InputDecoration(
                          filled: true,
                          fillColor: AppColor.TxtFieldColor,
                          label: Text(lan.getTexts("Email")),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextField(
                        controller: passController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passwordVisibility = !passwordVisibility;
                              });
                            },
                            icon: Icon(
                              passwordVisibility
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                          ),
                          filled: true,
                          fillColor: AppColor.TxtFieldColor,
                          label:  Text(lan.getTexts("Password")),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                        obscureText: passwordVisibility,
                      ),
                    ),

                    // Sign Up Button
                    const SizedBox(height: 10),
                    customButton(
                        text: lan.getTexts("logIn"),
                        color: AppColor.mainColor,
                        txtcolor: Colors.white,
                        onPressed: () {
                          authProvider.login(context, emailController.text.trim(), passController.text.trim());
                          passController.clear();
                        },
                        context: context),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text(
                            lan.getTexts("noAccount"),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, SignupPage.id);
                            },
                            child:  Text(
                              lan.getTexts("signUp"),
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
