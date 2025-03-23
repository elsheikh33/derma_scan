import 'package:flutter/material.dart';
import 'package:grad/screens/Login_page.dart';
import 'package:provider/provider.dart';
import '../Constants/Colors.dart';
import '../Constants/Design.dart';
import '../config/Provider/auth_provider.dart';

class ProfilePage extends StatefulWidget {
  static const String id = 'Profile_page';
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditing = false;
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController dobController;

  String? selectedGender;
  String? selectedSkinType;
  String? selectedAllergies;

  @override
  void initState() {
    super.initState();
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var userDetails = authProvider.userDetails;

    // Initialize controllers with user data
    usernameController = TextEditingController(text: userDetails?.username);
    emailController = TextEditingController(text: userDetails?.email);
    dobController = TextEditingController(text: userDetails?.birthdate);
    selectedGender = userDetails?.gender;

    if (userDetails?.skinType == null || userDetails?.skinType == "none") {
      selectedSkinType = null;
    } else {
      selectedSkinType = userDetails?.skinType;
    }

    if (userDetails?.allergies == null || userDetails?.allergies == "none") {
      selectedAllergies = null;
    } else {
      selectedAllergies = userDetails?.allergies;
    }
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    String username = authProvider.userDetails?.username ?? "User";
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
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
                      Text(
                        '$username\'s Profile',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(10),
                        ),
                        onPressed: () {showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Logout"),
                              content: const Text("Are you sure you want to logout?"),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    authProvider.logout(context);
                                    Navigator.pushReplacementNamed(context,LoginPage.id);
                                  },
                                  child: const Text(
                                    "Logout",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            );
                          },
                        );},
      
                        child: Text('logout',style: TextStyle(color: Colors.white),),
                      ),
                    ],
                  ),
                ),
      
                //======= =====================================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    spacing: 10,
                    children: [
                      CustomTextField(
                        isEditing: isEditing,
                        controller: usernameController,
                        label: 'Username',
                      ),
                      CustomTextField(
                        isEditing: isEditing,
                        controller: emailController,
                        label: 'Email',
                      ),
                      TextField(
                        controller: dobController,
                        readOnly: true,
                        decoration: InputDecoration(
                          enabled: isEditing,
                          filled: true,
                          fillColor: AppColor.TxtFieldColor,
                          labelText: "Date of Birth",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                        onTap: () => selectDate(context, dobController),
                      ),
      
                      const SizedBox(height: 3),
                      CustomDropdown(
                        isEditing: isEditing,
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
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: CustomDropdown(
                          isEditing: isEditing,
                          selectedValue:
                              (selectedAllergies != null &&
                                      [
                                        "none",
                                        "nuts",
                                        "pollen",
                                        "dust",
                                      ].contains(selectedAllergies))
                                  ? selectedAllergies
                                  : "none", // Default to "none"
                          items: [
                            {"value": "none", "label": "None"},
                            {"value": "nuts", "label": "Nuts"},
                            {"value": "pollen", "label": "Pollen"},
                            {"value": "dust", "label": "Dust"},
                          ],
                          title: "Allergies",
                          fillColor: AppColor.TxtFieldColor,
                          onChanged: (value) {
                            setState(() {
                              selectedAllergies = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: CustomDropdown(
                          isEditing: isEditing,
                          selectedValue:
                              (selectedSkinType != null &&
                                      [
                                        "none",
                                        "oily",
                                        "dry",
                                        "combination",
                                      ].contains(selectedSkinType))
                                  ? selectedSkinType
                                  : "none", // Default to "none"
                          items: [
                            {"value": "none", "label": "None"},
                            {"value": "oily", "label": "Oily"},
                            {"value": "dry", "label": "Dry"},
                            {"value": "combination", "label": "Combination"},
                          ],
                          title: "Skin Type",
                          fillColor: AppColor.TxtFieldColor,
                          onChanged: (value) {
                            setState(() {
                              selectedSkinType = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 20,
                        ),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.mainColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                            ),
                            onPressed: () async {
                              if (isEditing) {
                                await authProvider.saveUserDetails(
                                  context: context,
                                  username: usernameController.text,
                                  email: emailController.text,
                                  birthdate: dobController.text,
                                  gender:
                                      selectedGender ?? "", // Ensure it's not null
                                  skinType: selectedSkinType ?? "",
                                  allergies: selectedAllergies ?? "",
                                );
                              }
                              setState(() {
                                isEditing = !isEditing;
                              });
                            },

                            child: Text(isEditing ? "Save" : "Edit",style: TextStyle(color: Colors.white,),),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
