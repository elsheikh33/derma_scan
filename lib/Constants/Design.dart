
import 'package:flutter/material.dart';
import 'package:grad/screens/Home_page.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Colors.dart';

Widget customButton({
  required String text,
  required Color color,
  required Color txtcolor,
  required VoidCallback onPressed,
  required var context
}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: MaterialButton(
        onPressed: onPressed,
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: Text(
          text,
          style: TextStyle(color: txtcolor, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}

class CustomDropdown extends StatelessWidget {
  final String? selectedValue;
  final List<Map<String, String>> items;
  final String title;
  final Color fillColor;
  final Function(String?) onChanged;
  final bool? isEditing;

  const CustomDropdown({
    super.key,
    required this.selectedValue,
    required this.items,
    required this.title,
    required this.fillColor,
    required this.onChanged,
    this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        key: ValueKey(isEditing),
        value: selectedValue,
        items: items.map((item) {
          return DropdownMenuItem(
            value: item["value"],
            child: Text(item["label"]!),
          );
        }).toList(),
        onChanged: isEditing == true ? onChanged : null,
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor,
          labelText: title,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: isEditing == true ? Colors.black : Colors.grey,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: isEditing == true ? Colors.black : Colors.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: isEditing == true ? Colors.black : Colors.blue,
              width: 2,
            ),
          ),
        ),
        disabledHint: Text(selectedValue ?? "Select"),
      ),
    );
  }
}


class CustomBackArrow extends StatelessWidget {
  const CustomBackArrow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // White background
        shape: BoxShape.circle, // Circular shape
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Light shadow
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacementNamed(context, HomePage.id);
          }),
    );
  }
}
class BGImage extends StatelessWidget {
  String imageName;
  double? top;
  double? left;
  double? right;
  double? bottom;

  BGImage({
    required this.imageName,
     this.top,
     this.bottom,
    this.right,
    this.left
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,

      child: Image.asset(
        imageName,
        color: AppColor.BGImageColor,
      ),
    );
  }
}

Future<void> selectDate(BuildContext context, TextEditingController controller) async {
  DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime(2100),
  );

  if (picked != null) {
    controller.text = DateFormat('yyyy-MM-dd').format(picked); // Correct format
  }
}



class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? icon;
  final bool readOnly;
  final VoidCallback? onTap;
   final bool? isEditing;

  const CustomTextField({
    Key? key,
    this.isEditing,
    required this.controller,
    required this.label,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.icon,
    this.readOnly = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(

        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        enabled: isEditing,
        readOnly: readOnly,
        onTap: onTap,
        decoration: InputDecoration(
          prefixIcon: icon,
          filled: true,
          fillColor: AppColor.TxtFieldColor,
          labelText: label,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}

class locCard extends StatelessWidget {
  final int index;
  final List<Map<String, dynamic>> _hospitals;

  locCard({
    super.key,
    required List<Map<String, dynamic>> hospitals,
    required this.index,
  }) : _hospitals = hospitals;


  void _openGoogleMaps(double lat, double lng) async {
    final Uri url = Uri.parse("https://www.google.com/maps/search/?api=1&query=$lat,$lng");

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception("❌ Could not launch Google Maps.");
    }
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        double lat = _hospitals[index]['lat'];
        double lng = _hospitals[index]['lng'];
        _openGoogleMaps(lat, lng);
      },
      child: Card(
        color: const Color(0xffD9D9D9),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset('assets/Map.png'),
              ),
            ),
            Text("🏥 ${_hospitals[index]['name']}"),
            Text("📍 Distance: ${_hospitals[index]['distance']} km"),
          ],
        ),
      ),
    );
  }
}

Widget defaultClickableContainer({
  required String text,
  required double dw,
  required Function() onpress,
  String? text2,
  bool? isEditing,  // Add this to control when it's clickable
}) {
  return InkWell(
    onTap: isEditing == true ? onpress : null,  // Only allow tap if isEditing is true
    child: Container(
      width: dw,
      height: 50,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black,width: 1),
        color: isEditing == true ? Colors.white : Colors.grey[100], // Change color based on isEditing
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(color: Colors.black, fontSize: 13),
          ),
        ],
      ),
    ),
  );
}




