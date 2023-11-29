import 'package:flutter/material.dart';
import 'package:student_management/ui/component/text/large_text.dart';
import 'package:student_management/utils/colors.dart';

import '../../../utils/screen_util.dart';

class ChallengePage extends StatefulWidget {
  const ChallengePage({super.key});

  @override
  State<ChallengePage> createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  @override
  Widget build(BuildContext context) {

    final availabilityHeight = ScreenUtils.getRemainingHeight(context);
    double eachPartHeight = availabilityHeight * 3 / 10;
    double imageEdge = availabilityHeight * 2 / 10;

    return Scaffold(
      appBar: AppBar(
        title: LargeText(text: "Challenge"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ChallengeCategory(
                title: "Android",
                containerHeight: eachPartHeight,
                imagePath: "assets/image/jetpack_compose_logo.png",
                imageEdge: imageEdge,
                mainColor: Colors.green,
              ),
              ChallengeCategory(
                title: "Flutter",
                containerHeight: eachPartHeight,
                imagePath: "assets/image/flutter_logo.png",
                imageEdge: imageEdge,
                mainColor: Colors.blue,
              ),
              ChallengeCategory(
                title: "Swift",
                containerHeight: eachPartHeight,
                imagePath: "assets/image/swift_logo.png",
                imageEdge: imageEdge,
                mainColor: Colors.deepOrange,
              )
            ],
          )),
    );
  }
}

class ChallengeCategory extends StatelessWidget {

  final String title;
  final double containerHeight;
  final String imagePath;
  final double imageEdge;
  final Color mainColor;

  const ChallengeCategory(
      {super.key,
      required this.title,
      required this.containerHeight,
      required this.imagePath,
      required this.imageEdge,
      required this.mainColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: mainColor
      ),
      height: containerHeight,
      width: double.infinity,
      padding: const EdgeInsets.only(right: 8, left: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          LargeText(text: title, color: AppColors.absWhite, size: 20),
          Flexible(
            child: Row(
              children: [
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: AppColors.absWhite
                    ),
                    width: imageEdge,
                    height: imageEdge,
                    child: Image.asset(imagePath)),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ChallengeField(level: "Easy", textColor: mainColor),
                      ChallengeField(level: "Medium", textColor: mainColor),
                      ChallengeField(level: "Hard", textColor: mainColor),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      )
    );
  }
}

class ChallengeField extends StatelessWidget {

  final String level;
  final Color textColor;

  const ChallengeField({super.key, required this.level, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AppColors.absWhite
      ),
      child: Center(child: LargeText(text: level, color: textColor)),
    );
  }
}


