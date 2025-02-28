import 'package:flutter/material.dart';
import 'package:grad/screens/Profile_page.dart';

class MainPage extends StatefulWidget {
  static const String id = 'main_page';

  @override
  State<MainPage> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: selectedIndex == 0
          ? Column(  // Home Page Layout
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
                  Image.asset(
                    'assets/logo.png',
                    width: 40,
                  ),
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'We can learn to understand how our skin reveals its everyday story, helping us recognize the signs it shows us.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 120,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: AssetImage('assets/background.png'), // Add this asset
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: DiseaseGridView(),
          ),
        ],
      )
          : IndexedStack(  // Full Page Replacement for Other Tabs
        index: selectedIndex - 1, // Minus 1 because Home is not here
        children: [
          Center(child: Text('Locator Page')),
          Center(child: Text('AI Detect Page')),
          Center(child: Text('History Page')),
          ProfilePage(), // Full Profile Page
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF8E97FD),
            icon: ImageIcon(AssetImage('assets/homeIcon.png')),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/locatorIcon.png')),
            label: 'Locator',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/detectIcon.png')),
            label: 'AI DETECT',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/HistoryIcon.png')),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/profileIcon.png')),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  List<Widget> tabs = [
    DiseaseGridView(),
    Center(child: Text('Locator Page')),
    Center(child: Text('AI Detect Page')),
    Center(child: Text('History Page')),
    ProfilePage(),
  ];
}

class DiseaseGridView extends StatelessWidget {
  final List<Map<String, String>> diseases = [
    {'name': 'Herpes Zoster', 'image': 'assets/Herpsimage.png'},
    {'name': 'Psoriasis', 'image': 'assets/Psoriasisimage.png'},
    {'name': 'Eczema', 'image': 'assets/Eczemaimage.png'},
    {'name': 'Warts', 'image': 'assets/Wartsimage.png'},
    {'name': 'Urticaria', 'image': 'assets/Urticariaimage.png'},
    {'name': 'Bruise', 'image': 'assets/Bruiseimage.png'},
    {'name': 'Acne', 'image': 'assets/Acneimage.png'},
    {'name': 'Vitiligo', 'image': 'assets/Vitiligoimage.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Know more about your condition!",
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
                return GestureDetector(
                  onTap: () {
                    String routeName;
                    switch (diseases[index]['name']) {
                      case 'Herpes Zoster':
                        routeName = 'herpes_zoster';
                        break;
                      case 'Psoriasis':
                        routeName = 'psoriasis';
                        break;
                      case 'Eczema':
                        routeName = 'eczema';
                        break;
                      case 'Warts':
                        routeName = 'warts';
                        break;
                      case 'Urticaria':
                        routeName = 'urticaria';
                        break;
                      case 'Bruise':
                        routeName = 'bruise';
                        break;
                      case 'Acne':
                        routeName = 'acne';
                        break;
                      case 'Vitiligo':
                        routeName = 'vitiligo';
                        break;
                      default:
                        routeName = '';
                    }

                    if (routeName.isNotEmpty) {
                      Navigator.pushNamed(context, routeName);
                    }
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
                                color: Colors.grey.withOpacity(0.3),
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
                        diseases[index]['name']!,
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
