import 'package:flutter/material.dart';
import 'package:student_management/ui/component/image/image_svg.dart';
import 'package:student_management/ui/component/text/large_text.dart';
import 'package:student_management/ui/component/text/small_text.dart';

class ForgotPasswordHeader extends StatelessWidget {
  final String assetPath;
  final String title;
  final String desc;

  const ForgotPasswordHeader(
      {super.key,
      required this.assetPath,
      required this.title,
      required this.desc});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ImageSvg(assetPath: assetPath),
        const SizedBox(height: 48),
        LargeText(text: title, size: 24, fontWeight: FontWeight.w700),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SmallText(text: desc, textAlign: TextAlign.center),
        )
      ],
    );
  }
}
