import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {

  final String text;
  Color color;
  double size;
  FontWeight fontWeight;
  TextAlign textAlign;

  SmallText({super.key,
    required this.text,
    this.color = const Color(0xFF666376),
    this.size = 12,
    this.fontWeight = FontWeight.w400,
    this.textAlign = TextAlign.start});


  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: "PlusJakartaSans",
          fontSize: size,
          color: color,
          fontWeight: fontWeight
      ),
      textAlign: textAlign,
    );
  }
}