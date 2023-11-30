import 'package:flutter/material.dart';
import 'package:student_management/model/quiz.dart';
import 'package:student_management/ui/component/text/large_text.dart';
import 'package:student_management/utils/screen_util.dart';

class ChallengeResultScreen extends StatefulWidget {

  final List<Quiz> quizListResult;
  final double totalScore;

  const ChallengeResultScreen({super.key, required this.quizListResult, required this.totalScore});

  @override
  State<ChallengeResultScreen> createState() => _ChallengeResultScreenState();
}

class _ChallengeResultScreenState extends State<ChallengeResultScreen> {

  @override
  Widget build(BuildContext context) {

    final availableScreenHeight = ScreenUtils.getRemainingHeight(context);
    final resultHeight = availableScreenHeight * 2 / 5;
    final explainHeight = availableScreenHeight * 3 / 5;
    final imageEdge = resultHeight / 2;

    List<Quiz> resultList = widget.quizListResult;
    final typeQuiz = resultList.first.typeQuiz;
    int correctAnswerCount = 0;
    String pathImage;
    Color resultBgColor = Colors.green;
    String resultText = "";

    switch(typeQuiz.toLowerCase()) {
      case "android":
        resultBgColor = Colors.green;
        break;
      case "flutter":
        resultBgColor = Colors.blue;
        break;
      case "swift":
        resultBgColor = Colors.deepOrange;
        break;
      default:
        resultBgColor = Colors.green;
    }

    for (var quiz in resultList) {
      if(quiz.selectedAnswer.trim() == quiz.correctAnswer.trim()) {
        correctAnswerCount++;
      }
    }

    if(correctAnswerCount == resultList.length) { // max point
      pathImage = "assets/image/max_point_challenge.png";
      resultText = "Perfect";
    } else if (correctAnswerCount == resultList.length - 1) { // almost max point
      pathImage = "assets/image/almost_max_point_challenge.png";
      resultText = "Good";
    } else if (correctAnswerCount == 0) { // sieu ngu
      pathImage = "assets/image/zero_point_challenge.png";
      resultText = "Hjx @@";
    } else {
      pathImage = "assets/image/try_better_challenge.png";
      resultText = "Try better";
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
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: resultBgColor
              ),
              margin: const EdgeInsets.only(bottom: 24),
              height: resultHeight,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width: imageEdge,
                      height: imageEdge,
                      child: Image.asset(pathImage)
                  ),
                  LargeText(text: resultText),
                  LargeText(text: "Your score: ${widget.totalScore}")
                ],
              ),
            ),
            Container(
              height: explainHeight,
              width: double.infinity,
              child: ListView.builder(
                  itemCount: resultList.length,
                  itemBuilder: (context, index) {
                    return ChallengeResultField(currentItem: resultList[index]);
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class ChallengeResultField extends StatelessWidget {

  final Quiz currentItem;

  const ChallengeResultField({super.key, required this.currentItem});

  @override
  Widget build(BuildContext context) {

    final isCorrect = currentItem.selectedAnswer.trim() == currentItem.correctAnswer.trim();
    final textCorrect = isCorrect ? "(Correct)" : "(Incorrect)";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(child: LargeText(text: currentItem.question)),
            LargeText(text: textCorrect, color: isCorrect ? Colors.green : Colors.red)
          ],
        ),
        const SizedBox(height: 24),
        AnswerResultField(
          indexText: "A.",
          content: currentItem.answer1,
          selectedAnswer: currentItem.selectedAnswer,
          correctAnswer: currentItem.correctAnswer,
        ),
        AnswerResultField(
          indexText: "B.",
          content: currentItem.answer2,
          selectedAnswer: currentItem.selectedAnswer,
          correctAnswer: currentItem.correctAnswer,
        ),
        AnswerResultField(
          indexText: "C.",
          content: currentItem.answer3,
          selectedAnswer: currentItem.selectedAnswer,
          correctAnswer: currentItem.correctAnswer,
        ),
        AnswerResultField(
          indexText: "D.",
          content: currentItem.answer4,
          selectedAnswer: currentItem.selectedAnswer,
          correctAnswer: currentItem.correctAnswer,
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class AnswerResultField extends StatelessWidget {

  final String indexText;
  final String content;
  final String selectedAnswer;
  final String correctAnswer;

  const AnswerResultField(
      {super.key,
        required this.indexText,
        required this.content,
        required this.selectedAnswer,
      required this.correctAnswer});

  @override
  Widget build(BuildContext context) {

    Color backgroundColor = Colors.white;

    if(selectedAnswer == content) {
      if(selectedAnswer == correctAnswer) {
        backgroundColor = Colors.green;
      } else {
        backgroundColor = Colors.red;
      }
    }

    return GestureDetector(
      child: Container(
        color: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Column(
          children: [
            Row(
              children: [
                LargeText(text: indexText),
                const SizedBox(width: 8),
                Flexible(child: LargeText(text: content))
              ],
            )
          ],
        ),
      ),
    );
  }
}


