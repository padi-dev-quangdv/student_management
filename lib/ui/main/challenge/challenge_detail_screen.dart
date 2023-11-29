import 'package:flutter/material.dart';
import 'package:student_management/model/quiz.dart';
import 'package:student_management/ui/component/text/large_text.dart';
import 'package:student_management/ui/main/challenge/challenge_result_screen.dart';

class ChallengeDetailScreen extends StatefulWidget {

  final List<Quiz> quizList;
  final Color buttonColor;

  const ChallengeDetailScreen({super.key, required this.quizList, required this.buttonColor});

  @override
  State<ChallengeDetailScreen> createState() => _ChallengeDetailScreenState();
}

class _ChallengeDetailScreenState extends State<ChallengeDetailScreen> {

  int selectedIndex = 0;
  String selectedAnswer = "";

  @override
  Widget build(BuildContext context) {
    Quiz currentItem = widget.quizList[selectedIndex];
    if(selectedAnswer.isNotEmpty) {
      currentItem.selectedAnswer = selectedAnswer;
    }

    bool isLastQuestion = selectedIndex == widget.quizList.length - 1;
    bool isFirstQuestion = selectedIndex == 0;
    String textButton = isLastQuestion ? "Submit" : "Next";
    
    return Scaffold(
      appBar: AppBar(
        title: LargeText(text: "Question ${selectedIndex + 1}"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(child: LargeText(text: currentItem.question)),
            const SizedBox(height: 24),
            AnswerField(
              indexText: "A.",
              content: currentItem.answer1,
              selectedAnswer: currentItem.selectedAnswer,
              onTap: () {
                setState(() {
                  selectedAnswer = currentItem.answer1;
                });
              },
            ),
            AnswerField(
              indexText: "B.",
              content: currentItem.answer2,
              selectedAnswer: currentItem.selectedAnswer,
              onTap: () {
                setState(() {
                  selectedAnswer = currentItem.answer2;
                });
              },
            ),
            AnswerField(
              indexText: "C.",
              content: currentItem.answer3,
              selectedAnswer: currentItem.selectedAnswer,
              onTap: () {
                setState(() {
                  selectedAnswer = currentItem.answer3;
                });
              },
            ),
            AnswerField(
              indexText: "D.",
              content: currentItem.answer4,
              selectedAnswer: currentItem.selectedAnswer,
              onTap: () {
                setState(() {
                  selectedAnswer = currentItem.answer4;
                });
              },
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                      onPressed: () {
                        if (!isFirstQuestion) {
                          setState(() {
                            selectedIndex--;
                            selectedAnswer = "";
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: widget.buttonColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)
                          )
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text("Previous",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'PlusJakartaSans')),
                      )),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                      onPressed: () {
                        if (isLastQuestion) {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                            return ChallengeResultScreen(quizListResult: widget.quizList);
                          }));
                        } else {
                          setState(() {
                            selectedIndex++;
                            selectedAnswer = "";
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: widget.buttonColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(textButton,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'PlusJakartaSans')),
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AnswerField extends StatelessWidget {

  final String indexText;
  final String content;
  final String selectedAnswer;
  final Function()? onTap;

  const AnswerField(
      {super.key,
      required this.indexText,
      required this.content,
      required this.selectedAnswer,
      required this.onTap});

  @override
  Widget build(BuildContext context) {

    bool isSelectedAnswer = selectedAnswer == content;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: isSelectedAnswer ? Colors.green : Colors.white,
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

