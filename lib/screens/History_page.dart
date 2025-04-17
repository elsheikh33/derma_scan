import 'package:flutter/material.dart';
import 'package:grad/Constants/Colors.dart';
import 'package:provider/provider.dart';

import '../config/Provider/auth_provider.dart';

class HistoryPage extends StatefulWidget {
  static const String id = "History_page";

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late TextEditingController usernameController;

  State<HistoryPage> createState() => _HistoryPageState();

  void initState() {
    super.initState();
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var userDetails = authProvider.userDetails;

    // Initialize controllers with user data
    usernameController = TextEditingController(text: userDetails?.username);
     }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    String username = authProvider.userDetails?.username ?? "User";
    final mockDetections = [
      {
        'disease': 'Eczema',
        'date': '30/3/2025',
        'color': Color(0xFF8E97FD),
        'image': 'assets/eczemaImage.png',
      },
      {
        'disease': 'Acne',
        'date': '14/4/2025',
        'color': Color(0xFFFFC288),
        'image': 'assets/acneImage.png',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
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
            const SizedBox(height: 20),
             Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
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
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 4),
              child: Row(
                children: [
                  Text(
                    'VIEW YOUR PREVIOUS DETECTIONS',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),


            // Grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  itemCount: mockDetections.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder: (context, index) {
                    final item = mockDetections[index];
                    return Container(
                      decoration: BoxDecoration(
                        color:AppColor.mainColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                item['image'] as String,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            item['disease'] as String,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['date'] as String,
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                textStyle: const TextStyle(fontSize: 14),
                              ),
                              child: const Text("View"),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
        ]
        ),
      ),
    );
  }
}


