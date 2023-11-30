import 'package:flutter/material.dart';
import 'package:student_management/model/student.dart';
import 'package:student_management/ui/component/text/large_text.dart';

class TopRankingWidget extends StatelessWidget {

  final Student currentStudent;
  final int heightFlexRanking;
  final String textNumberRanking;

  const TopRankingWidget(
      {super.key,
        required this.currentStudent,
        required this.heightFlexRanking,
        required this.textNumberRanking});

  @override
  Widget build(BuildContext context) {

    Color color;
    switch(currentStudent.className.toLowerCase()) {
      case "android":
        color = Colors.green;
        break;
      case "flutter":
        color = Colors.blue;
        break;
      case "swift":
        color = Colors.deepOrange;
        break;
      default:
        color = Colors.green;
    }


    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
            flex: 5,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LargeText(text: currentStudent.fullName),
                LargeText(
                    text: textNumberRanking,
                    fontWeight: FontWeight.w900,
                    color: color,
                    size: 24),
              ],
            )),
        Expanded(
          flex: heightFlexRanking,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            color: color,
            child:  Center(child: LargeText(text: currentStudent.getSummary().toString())),
          ),
        )
      ],
    );
  }
}