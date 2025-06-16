  import 'package:flutter/material.dart';
  import 'package:grad/Constants/Colors.dart';
  import 'package:grad/screens/Detect_page.dart';
  import 'package:grad/screens/History_page.dart';
  import 'package:grad/screens/Locator_page.dart';
  import 'package:grad/screens/Profile_page.dart';
  import 'package:provider/provider.dart';

  import '../config/Provider/language_provider.dart';

  class MainPage extends StatefulWidget {
    static const String id = 'main_page';
    const MainPage({super.key});
    @override
    State<MainPage> createState() => _MainScreenState();
  }

  class _MainScreenState extends State<MainPage> {
    int selectedIndex = 0;

    @override
    Widget build(BuildContext context) {
      var lan = Provider.of<LanguageProvider>(context, listen: true);

      return Scaffold(
        backgroundColor: Colors.white,
        body:
            selectedIndex == 0
                ? Column(
                  // Home Page Layout
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'DERMA',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 24,
                              ),
                            ),
                            Image.asset('assets/logoo.png', width: 28),
                            const Text(
                              'SCAN',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        lan.getTexts("mainTitle"),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(child: DiseaseGridView()),
                  ],
                )
                : IndexedStack(
                  index: selectedIndex - 1, // Minus 1 because Home is not here
                  children: [
                    LocatorPage(),
                    DetectPage(),
                    HistoryPage(),
                    ProfilePage(),
                  ],
                ),
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          unselectedItemColor: Colors.grey,
          selectedItemColor: AppColor.mainColor,

          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: ImageIcon(AssetImage('assets/homeIcon.png')),
              label: lan.getTexts("homeToggle"),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: ImageIcon(AssetImage('assets/locatorIcon.png')),
              label: lan.getTexts("locatorToggle"),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: ImageIcon(AssetImage('assets/detectIcon.png')),
              label: lan.getTexts("detectToggle"),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: ImageIcon(AssetImage('assets/HistoryIcon.png')),
              label: lan.getTexts("historyToggle"),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: ImageIcon(AssetImage('assets/profileIcon.png')),
              label: lan.getTexts("profileToggle"),
            ),
          ],
        ),
      );
    }
  }

  class DiseaseGridView extends StatelessWidget {
    final List<Map<String, String>> diseases = [
      {'key': 'herpes_zoster', 'image': 'assets/herpsIamge.png'},
      {'key': 'psoriasis', 'image': 'assets/PsoriasisImage.png'},
      {'key': 'eczema', 'image': 'assets/eczemaImage.png'},
      {'key': 'warts', 'image': 'assets/wartsImage.png'},
      {'key': 'urticaria', 'image': 'assets/UrticariaImage.png'},
      {'key': 'bruise', 'image': 'assets/BruiseImage.png'},
      {'key': 'acne', 'image': 'assets/acneImage.png'},
      {'key': 'vitiligo', 'image': 'assets/VitiligoImage.png'},
      {'key': 'dermatitis', 'image': 'assets/atopic_dermatitis.png'},
      {'key': 'basal_cell', 'image': 'assets/BasalCellCarcinomaImage.png'},
      {'key': 'melanoma', 'image': 'assets/melanomaImage.png'},
      {'key': 'cancer', 'image': 'assets/CancerDisease.png'},
    ];

    @override
    Widget build(BuildContext context) {
      var lan = Provider.of<LanguageProvider>(context, listen: true);

      return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lan.getTexts("Know more about your condition!"),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: diseases.length,
                itemBuilder: (context, index) {
                  var lan = Provider.of<LanguageProvider>(context, listen: true);

                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, diseases[index]['key']!);
                    },
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.15),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                              image: DecorationImage(
                                image: AssetImage(diseases[index]['image']!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          lan.getTexts(
                            diseases[index]['key']!,
                          ), // Use the key to get translated text
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }
  }
