import 'package:flutter/material.dart';
import 'package:grad/screens/Login_page.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Constants/Colors.dart';
import '../Constants/Design.dart';
import '../config/Provider/auth_provider.dart';
import '../config/Provider/language_provider.dart';

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
    usernameController = TextEditingController();
    emailController = TextEditingController();
    dobController = TextEditingController();

    _loadUserData();
  }

  void _loadUserData() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userDetails = authProvider.userDetails;

    if (userDetails != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          usernameController.text = userDetails.username ?? '';
          emailController.text = userDetails.email ?? '';

          // Parse the birthdate string to DateTime and format it for display
          final DateTime? birthDate = authProvider.parseBirthdate(userDetails.birthdate);
          dobController.text = birthDate != null
              ? DateFormat('yyyy-MM-dd').format(birthDate)
              : '';

          print('DOB set to: ${dobController.text}');

          selectedGender = userDetails.gender;
          selectedSkinType = (userDetails.skinType == null || userDetails.skinType == "none")
              ? null
              : userDetails.skinType;
          selectedAllergies = (userDetails.allergies == null || userDetails.allergies == "none")
              ? null
              : userDetails.allergies;
        });
      });
    }
  }

  // Add this to listen to auth changes
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final authProvider = Provider.of<AuthProvider>(context);
    if (authProvider.userDetails != null) {
      _loadUserData();
    }
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    String username = authProvider.userDetails?.username ?? "User";
    var lan =Provider.of<LanguageProvider>(context, listen: true);
    var dw =MediaQuery.of(context).size.width ;
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
                      Expanded(
                        child: Text(
                          '$username ${lan.getTexts("profileToggle")}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(10),
                        ),
                        onPressed: () {showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title:  Text(lan.getTexts("logOut")),
                              content:  Text(lan.getTexts("checkMssg")),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child:  Text(lan.getTexts("cancel")),
                                ),
                                TextButton(
                                  onPressed: () {
                                    authProvider.logout(context);
                                    Navigator.pushReplacementNamed(context,LoginPage.id);
                                  },
                                  child:  Text(
                                    lan.getTexts("logOut"),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            );
                          },
                        );},

                        child: Text(lan.getTexts("logOut"),style: TextStyle(color: Colors.white),),
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
                        label: lan.getTexts("Username"),
                      ),
                      CustomTextField(
                        isEditing: false,
                        controller: emailController,
                        label: lan.getTexts("Email"),
                      ),
                      TextField(
                        controller: dobController,
                        readOnly: true,
                        decoration: InputDecoration(
                          enabled: isEditing,
                          filled: true,
                          fillColor: AppColor.TxtFieldColor,
                          labelText: lan.getTexts("Date of Birth"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          suffixIcon: Icon(Icons.calendar_today),
                          errorText: dobController.text.isEmpty && isEditing
                              ? 'Please select a date'
                              : null,
                        ),
                        onTap: () => isEditing ? selectDate(context, dobController) : null,
                      ),
      
                      const SizedBox(height: 3),
                      CustomDropdown(
                        isEditing: isEditing,
                        selectedValue: selectedGender,
                        items: [
                          {"value": "M", "label": lan.getTexts("Male")},
                          {"value": "F", "label":  lan.getTexts("Female")},

                        ],
                        title: lan.getTexts("Gender"),
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
                            {"value": "none", "label": lan.getTexts("None_question")},
                            {"value": "nuts", "label": lan.getTexts("Nuts")},
                            {"value": "pollen", "label": lan.getTexts("Pollen")},
                            {"value": "dust", "label": lan.getTexts("Dust")},
                            {"value": "others", "label": lan.getTexts("Others")},

                          ],
                          title: lan.getTexts("Allergies"),
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
                            {"value": "none", "label": lan.getTexts("None_question")},
                            {"value": "oily", "label": lan.getTexts("Oily_question")},
                            {"value": "dry", "label": lan.getTexts("Dry_question")},
                            {"value": "combination", "label": lan.getTexts("Combination_question")},
                          ],
                          title: lan.getTexts("skin_type"),
                          fillColor: AppColor.TxtFieldColor,
                          onChanged: (value) {
                            setState(() {
                              selectedSkinType = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: CustomDropdown(
                          isEditing: isEditing,
                          selectedValue: lan.defLan == 0 ? "Arabic" : "English", // Current language selection
                          items: [
                            {"value": "Arabic", "label": lan.getTexts("arabic")},
                            {"value": "English", "label": lan.getTexts("english")},
                          ],
                          title: "Language",
                          fillColor: AppColor.TxtFieldColor,
                          onChanged: (value) {
                            if (value == "Arabic") {
                              Provider.of<LanguageProvider>(context, listen: false).changeLan(lan: 0);
                            } else {
                              Provider.of<LanguageProvider>(context, listen: false).changeLan(lan: 1);
                            }
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
                                // Validate the date format before saving
                                final dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
                                if (!dateRegex.hasMatch(dobController.text)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Please enter a valid date in YYYY-MM-DD format')),
                                  );
                                  return;
                                }

                                await authProvider.saveUserDetails(
                                  context: context,
                                  username: usernameController.text,
                                  email: emailController.text,
                                  birthdate: dobController.text,
                                  gender: selectedGender ?? "",
                                  skinType: selectedSkinType ?? "",
                                  allergies: selectedAllergies ?? "",
                                );
                              }
                              setState(() {
                                isEditing = !isEditing;
                              });
                            },

                            child: Text(isEditing ? lan.getTexts("Save") : lan.getTexts("Edit"),style: TextStyle(color: Colors.white,),),
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
