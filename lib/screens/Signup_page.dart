
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Constants/Colors.dart';
import '../Constants/Design.dart';
import '../Controller/auth.dart';
import 'Login_page.dart';


class SignupPage extends StatefulWidget {
  static const String id = "Signup_page";
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final auth = FirebaseAuth.instance;
  String? selectedGender;
  TextEditingController dateController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool passwordVisibility = true;
  late String email;
  late String password;


  @override
  Widget build(BuildContext context) {
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
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Image.asset(
                      'assets/BG1.png',
                      color: AppColor.BGImageColor,
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 20,
                    child: CustomBackArrow(),
                  ),

                  // Top-right image
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Image.asset(
                      'assets/BG2.png',
                      color: AppColor.BGImageColor,
                    ),
                  ),

                  // Bottom-left image
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Image.asset(
                      'assets/BG4.png',
                      color: AppColor.BGImageColor,
                    ),
                  ),

                  // Bottom-right image
                  Positioned(
                    bottom: -5,
                    right: 0,
                    child: Image.asset(
                      'assets/BG3.png',
                      color: AppColor.BGImageColor,
                    ),
                  ),
                  Container(
                    width: w,
                    height: h * 0.40,
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text(
                          'Create Your Account',
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
                          child: TextField(
                            controller: userController,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: AppColor.TxtFieldColor,
                              label: Text('Username'),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                            ),
                          ),
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
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextField(
                        onChanged: (value) {
                          email = value;
                        },
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: AppColor.TxtFieldColor,
                          label: Text('Email'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextField(
                        onChanged: (value) {
                          password = value;
                        },
                        controller: passController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock,color: Colors.grey,),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passwordVisibility = !passwordVisibility;
                              });
                            },
                            icon: Icon(
                              passwordVisibility
                                  ? Icons.visibility_off
                                  : Icons.visibility,color: Colors.grey,
                            ),
                          ),
                          filled: true,
                          fillColor: AppColor.TxtFieldColor,
                          label: const Text('Password'),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                        ),
                        obscureText: passwordVisibility,
                      ),
                    ),

                    // Date of Birth Field with Date Picker
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextField(
                        controller: dateController,
                        readOnly: true,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: AppColor.TxtFieldColor,
                          labelText: "Date of Birth",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          suffixIcon: Icon(Icons.calendar_today), // Calendar icon
                        ),
                        onTap: () => _selectDate(context), // Open date picker
                      ),
                    ),

                    // Gender Dropdown
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CustomDropdown(
                        selectedValue: selectedGender,
                        items: [
                          {"value": "M", "label": "Male"},
                          {"value": "F", "label": "Female"},
                        ],
                        title: "Gender",
                        fillColor: AppColor.TxtFieldColor,
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value;
                          });
                        },
                      ),
                    ),

                    // Sign Up Button
                    const SizedBox(height: 10),
                    customButton(
                        text: 'Sign Up',
                        color: AppColor.mainColor,
                        txtcolor: Colors.white,
                        onPressed: () async {
                         await Auth().signup(email: email, password: password);
                        },
                        context: context
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 10,top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "ALREADY HAVE AN ACCOUNT? ",
                            style: TextStyle(
                              color: Colors.black,
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



  // Function to open date picker
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // Format date
      setState(() {
        dateController.text = formattedDate; // Update text field
      });
    }
  }



}


