import 'package:flutter/material.dart';
import '../Constants/Colors.dart';

class testProfile extends StatelessWidget{
  static const String id = 'Profile_page';
  const testProfile({super.key});
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
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black,fontSize: 20),
                    ),
                    Image.asset('assets/images/logo.png'),
                    const Text(
                      'SCAN',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black,fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20,left: 25,right: 25),
              child: Row(
                children: [
                  const Text(
                    'kazas Profile',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black,fontSize: 20),
                  ),
                  SizedBox(width: 160),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.mainColor, // Background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // Rounded corners
                        ),
                        padding: EdgeInsets.all(10),
                      ),
                      onPressed:() =>() {
                        //LOGIC EL SAVE
                      },child: Text("Save",)
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20), // Same padding as other fields
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 40, // Ensures same width
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    //controller: userController,
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
          ],
        ),
      ),
    );
  }
}