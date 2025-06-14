import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Constants/Colors.dart';
import '../Constants/Design.dart';
import '../config/Provider/auth_provider.dart';
import '../config/Provider/language_provider.dart';
import 'Login_page.dart';

class SignupPage extends StatefulWidget {
  static const String id = "Signup_page";
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String? selectedGender;
  TextEditingController dateController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool passwordVisibility = true;



  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var lan =Provider.of<LanguageProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  BGImage(imageName: 'assets/BG1.png', top: 0, left: 0),
                  Positioned(
                    top: 20,
                    left: 20,
                    child: CustomBackArrow(),
                  ),
                  BGImage(imageName: 'assets/BG2.png', top: 0, right: 0),
                  BGImage(imageName: 'assets/BG4.png', bottom: 0, left: 0),
                  BGImage(imageName: 'assets/BG3.png', bottom: -5, right: 0),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.40,
                    child:  Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text(
                          lan.getTexts("createAcc"),
                          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20), // Same padding as other fields
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 40, // Ensures same width
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: CustomTextField(controller: userController, label: lan.getTexts("Username")),
                        ),
                      ),
                    ),
                  )

                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(controller: emailController, label: lan.getTexts('Email')),
                    CustomTextField(
                      controller: passController,
                      label: lan.getTexts('Password'),
                      obscureText: passwordVisibility,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            passwordVisibility = !passwordVisibility;
                          });
                        },
                        icon: Icon(passwordVisibility ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: TextField(
                        controller: dateController,
                        readOnly: true,
                        decoration:  InputDecoration(
                          filled: true,
                          fillColor: AppColor.TxtFieldColor,
                          labelText: lan.getTexts("Date of Birth"),
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                        onTap: () => selectDate(context, dateController),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: CustomDropdown(
                        isEditing: true,
                        selectedValue: selectedGender,
                        items: [
                          {"value": "M", "label": lan.getTexts("Male")},
                          {"value": "F", "label": lan.getTexts("Female")},
                        ],
                        title: lan.getTexts("Gender"),
                        fillColor: AppColor.TxtFieldColor,
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value;
                          });
                        },
                      ),
                    ),

                    const SizedBox(height: 10),
                    customButton(
                      text: lan.getTexts("signUp"),
                      color: AppColor.mainColor,
                      txtcolor: Colors.white,
                      onPressed: () async {
                        try {
                          await authProvider.signup(
                            context: context,
                            email: emailController.text.trim(),
                            password: passController.text.trim(),
                            birthdate: DateFormat('yyyy-MM-dd').parse(dateController.text.trim()),
                            gender: selectedGender!,
                            userName: userController.text.trim(),
                          );
                          emailController.clear();
                          passController.clear();
                          dateController.clear();
                          selectedGender = null;
                          userController.clear();
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(lan.getTexts("errorM1"))),
                          );
                        }
                      },
                      context: context,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text(lan.getTexts("accountCheckHome"), style: TextStyle(color: Colors.black, fontSize: 12)),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, LoginPage.id);
                            },
                            child:  Text(
                              lan.getTexts("logIn"),
                              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12),
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
