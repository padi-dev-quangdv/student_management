import 'package:flutter/material.dart';
import 'package:student_management/ui/component/text/large_text.dart';
import 'package:student_management/ui/component/text/medium_text.dart';

class ProfileField extends StatelessWidget {
  final String title;
  final String content;
  final Function() onTap;

  const ProfileField({super.key, required this.title, required this.content, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Expanded(flex: 2, child: MediumText(text: title)),
            Expanded(flex: 3, child: LargeText(text: content)),
            const Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.navigate_next),
                ))
          ],
        ),
      ),
    );
  }
}
