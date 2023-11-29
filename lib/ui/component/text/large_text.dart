import 'package:flutter/material.dart';

class LargeText extends StatelessWidget {

  final String text;
  Color color;
  double size;
  FontWeight fontWeight;
  Function()? onTap;
  int maxLines;
  TextOverflow overflow;

  LargeText({super.key,
  required this.text,
  this.color = const Color(0xFF4B485E),
  this.size = 16,
  this.fontWeight = FontWeight.w600,
  this.onTap,
  this.maxLines = 1,
  this.overflow = TextOverflow.ellipsis});


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
