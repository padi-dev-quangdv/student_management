import 'package:flutter/material.dart';
import 'package:student_management/ui/component/image/image_svg.dart';
import 'package:student_management/ui/component/text/large_text.dart';
import 'package:student_management/ui/component/text/small_text.dart';

class AuthHeader extends StatelessWidget {
  final String desc;

  const AuthHeader({super.key,
  required this.desc});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ImageSvg(assetPath: "assets/image/logo.svg"),
        const SizedBox(height: 16),
        LargeText(text: "Q UNIVERSITY", size: 24),
        const SizedBox(height: 20),
        SmallText(text: desc)
      ],
    );
  }
}
