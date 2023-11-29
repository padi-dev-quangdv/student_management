import 'package:flutter/material.dart';
import 'package:student_management/ui/component/text/large_text.dart';
import 'package:student_management/ui/component/text/medium_text.dart';

class DetailRankingField extends StatelessWidget {

  final String title;
  final String content;

  const DetailRankingField({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(flex: 2, child: MediumText(text: title)),
          Expanded(flex: 4, child: LargeText(text: content, size: 14))
        ],
      ),
    );
  }
}