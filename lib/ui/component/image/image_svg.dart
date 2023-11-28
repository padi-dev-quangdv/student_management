import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageSvg extends StatelessWidget {
  final String assetPath;

  const ImageSvg({super.key,
  required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(assetPath);
  }
}
