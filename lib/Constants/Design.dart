
import 'package:flutter/material.dart';

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

  const CustomDropdown({
    super.key,
    required this.selectedValue,
    required this.items,
    required this.title,
    required this.fillColor,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        items: items.map((item) {
          return DropdownMenuItem(
            value: item["value"],
            child: Text(item["label"]!),
          );
        }).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor,
          labelText: title,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
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
            Navigator.pop(context);
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


