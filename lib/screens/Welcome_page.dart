import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Constants/Colors.dart';
import '../Constants/Design.dart';
import '../config/Provider/auth_provider.dart';
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
                          'SKIP >',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
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
                      'Hi $username, Welcome',
                      style: TextStyle(
                          color: Color(0xFFFFBF53),
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Help us know more about you',
                    style: TextStyle(
                        color: Color(0xFFFFBF53),
                        fontSize: 24,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomDropdown(
                    selectedValue: selectedSkinType,
                    items: [
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
                    isEditing: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomDropdown(
                    selectedValue: selectedAllergies,
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
                    isEditing: true,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: customButton(
                    text: 'Get Started',
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
