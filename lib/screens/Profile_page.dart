import 'package:flutter/material.dart';
import '../Constants/Colors.dart';

class ProfilePage extends StatefulWidget {
  static const String id = 'Profile_page';
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditing = false;

  // Controllers for TextFields
  final TextEditingController usernameController = TextEditingController(text: "semo");
  final TextEditingController emailController = TextEditingController(text: "zedansemo@gmail.com");
  final TextEditingController passwordController = TextEditingController(text: "******");
  final TextEditingController dobController = TextEditingController(text: "11/1/2003");

  // Dropdown Values (real vals mn el signup)
  String genderValue = 'F';
  String skinTypeValue = 'Oily';

  // TextField design
  Widget buildTextField(String label, TextEditingController controller, bool isPassword) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 5),
          TextField(
            controller: controller,
            enabled: isEditing,
            obscureText: isPassword,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColor.TxtFieldColor,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
        ],
      ),
    );
  }
  // Date Picker Method for DOB
  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2003, 11, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        dobController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'DERMA',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    Image.asset('assets/logo.png'),
                    const Text(
                      'SCAN',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
//======================================================
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 25, right: 25),
              child: Row(
                children: [
                  const Text(
                    'ssmo\'s Profile',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(10),
                    ),
                    onPressed: () {
                      setState(() {
                        isEditing = !isEditing;
                        if (!isEditing) {
                          // Save logic
                          print("Saved: Username: ${usernameController.text}");
                          print("Email: ${emailController.text}");
                          print("Password: ${passwordController.text}");
                          print("DOB: ${dobController.text}");
                          print("Gender: $genderValue");
                          print("Skin Type: $skinTypeValue");
                        }
                      });
                    },
                    child: Text(isEditing ? "Save" : "Edit"),
                  ),
                ],
              ),
            ),

//============================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                spacing:10,
                children: [
                  buildTextField('Username', usernameController, false),
                  buildTextField('Email', emailController, false),
                  buildTextField('Password', passwordController, true),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Date of Birth',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: dobController,
                        enabled: false,
                        onTap: isEditing ? () => selectDate(context) : null,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColor.TxtFieldColor,
                          suffixIcon: const Icon(Icons.calendar_today),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Gender',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: AppColor.TxtFieldColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: DropdownButton<String>(
                          value: genderValue,
                          onChanged: isEditing
                              ? (String? newValue) {
                            setState(() {
                              genderValue = newValue!;
                            });
                          }
                              : null,
                          items: <String>['M', 'F', 'Other']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          underline: Container(),
                          isExpanded: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Skin Type',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: AppColor.TxtFieldColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: DropdownButton<String>(
                          value: skinTypeValue,
                          onChanged: isEditing
                              ? (String? newValue) {
                            setState(() {
                              skinTypeValue = newValue!;
                            });
                          }
                              : null,
                          items: <String>['Oily', 'Dry', 'Combination', 'Sensitive', 'Normal']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          underline: Container(),
                          isExpanded: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
