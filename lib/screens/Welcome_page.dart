import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Constants/Colors.dart';
import '../Constants/Design.dart';
import '../config/Provider/auth_provider.dart';
import '../config/Provider/language_provider.dart';
import 'Main_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});
  static const String id = 'Welcome_page';

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String? selectedSkinType;
  String? selectedAllergies;

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    final username = authProvider.userDetails?.username ?? "User";
    var lan =Provider.of<LanguageProvider>(context, listen: true);

    return SafeArea(
        child: Scaffold(
          backgroundColor: AppColor.mainColor,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image.asset('assets/ProfilePic.png'),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '$username',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        child: Text(
                          lan.getTexts("Skip"),
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                            selectedSkinType = null;
                            selectedAllergies = null;
                            Navigator.pushReplacementNamed(context, MainPage.id);
                          },

                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Center(
                    child: Text(
                      '${lan.getTexts("Hi")}, $username',
                      style: TextStyle(
                          color: Color(0xFFFFBF53),
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    lan.getTexts("Help_question"),
                    style: TextStyle(
                        color: Color(0xFFFFB73E),
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomDropdown(
                    isEditing: true,
                    selectedValue: selectedSkinType,
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
                  padding: const EdgeInsets.all(8.0),
                  child: CustomDropdown(
                    isEditing: true,
                    selectedValue: selectedAllergies,
                    items: [
                      {"value": "none", "label": lan.getTexts("None_question")},
                      {"value": "nuts", "label": lan.getTexts("Nuts")},
                      {"value": "pollen", "label": lan.getTexts("Pollen")},
                      {"value": "dust", "label": lan.getTexts("Dust")},
                     // {"value": "others", "label": "Others"},
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
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: customButton(
                    text: lan.getTexts("get started"),
                    color: AppColor.TxtFieldColor,
                    txtcolor: Colors.black,
                    onPressed: () async {
                      if (selectedSkinType != null && selectedAllergies != null) {
                        await authProvider.addAdditionalUserDetails(selectedSkinType,selectedAllergies);
                      }
                      Navigator.pushReplacementNamed(context, MainPage.id);
                    },
                    context: context,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
