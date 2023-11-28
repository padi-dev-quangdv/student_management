import 'package:flutter/material.dart';

class MediumText extends StatelessWidget {

  final String text;
  Color color;
  double size;
  FontWeight fontWeight;
  Function()? onTap;

  MediumText({super.key,
    required this.text,
    this.color = const Color(0xFF666376),
    this.size = 14,
    this.fontWeight = FontWeight.w500,
    this.onTap});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
            fontFamily: "PlusJakartaSans",
            fontSize: size,
            color: color,
            fontWeight: fontWeight
        ),
      ),
    );
  }
}
