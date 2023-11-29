import 'package:flutter/material.dart';
import 'package:student_management/model/quiz.dart';
import 'package:student_management/ui/component/text/large_text.dart';
import 'package:student_management/utils/screen_util.dart';

class ChallengeResultScreen extends StatefulWidget {

  final List<Quiz> quizListResult;

  const ChallengeResultScreen({super.key, required this.quizListResult});

  @override
  State<ChallengeResultScreen> createState() => _ChallengeResultScreenState();
}

class _ChallengeResultScreenState extends State<ChallengeResultScreen> {

  @override
  Widget build(BuildContext context) {

    final availableScreenHeight = ScreenUtils.getRemainingHeight(context);
    final halfScreen = availableScreenHeight / 2;

    List<Quiz> resultList = widget.quizListResult;
    final typeQuiz = resultList.first.typeQuiz;
    double totalScore = 0;
    double plusScore = 10;
    switch (typeQuiz) {
      case "easy":
        plusScore = 10;
        break;
      case "medium":
        plusScore = 20;
      case "hard":
        plusScore = 30;
        break;
      default:
        plusScore = 10;
    }
    for (var quiz in resultList) {
      if(quiz.selectedAnswer == quiz.correctAnswer) {
        totalScore += plusScore;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: LargeText(text: "Result"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          children: [
            Container(
              height: halfScreen,
              width: double.infinity,
              child: Column(
                children: [
                  Text("Your score: $totalScore")
                ],
              ),
            ),
            Container(
              child: ListView.builder(
                  itemCount: resultList.length,
                  itemBuilder: (context, index) {
                    return Text("");
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class ChallengeResultField extends StatelessWidget {
  const ChallengeResultField({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

