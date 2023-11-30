import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management/model/quiz.dart';
import 'package:student_management/model/student.dart';
import 'package:student_management/repository/database_repository.dart';
import 'package:student_management/ui/component/text/large_text.dart';
import 'package:student_management/ui/main/challenge/challenge_result_screen.dart';

import '../../../model/local_user.dart';

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

    final user = Provider.of<LocalUser?>(context);
    DatabaseRepository databaseRepository = DatabaseRepository(uid: user!.uid);

    Quiz currentItem = widget.quizList[selectedIndex];
    if(selectedAnswer.isNotEmpty) {
      currentItem.selectedAnswer = selectedAnswer;
    }

    bool isLastQuestion = selectedIndex == widget.quizList.length - 1;
    bool isFirstQuestion = selectedIndex == 0;
    String textButton = isLastQuestion ? "Submit" : "Next";

    final level = widget.quizList.first.level;
    final typeQuiz = widget.quizList.first.typeQuiz;
    double totalScore = 0;
    double plusScore = 10;

    switch (level) {
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
                  child: StreamBuilder(
                    stream: databaseRepository.student,
                    builder: (context, snapshot) {

                      Student student = snapshot.hasData
                          ? snapshot.data ?? Student.defaultStudent()
                          : Student.defaultStudent();

                      return ElevatedButton(
                          onPressed: () async {
                            if (isLastQuestion) {
                              try {
                                for (var quiz in widget.quizList) {
                                  if(quiz.selectedAnswer.trim() == quiz.correctAnswer.trim()) {
                                    totalScore += plusScore;
                                  }
                                }
                                switch(typeQuiz) {
                                  case "android":
                                    student.android += totalScore;
                                    break;
                                  case "flutter":
                                    student.flutter += totalScore;
                                    break;
                                  case "swift":
                                    student.swift += totalScore;
                                    break;
                                }

                                await databaseRepository.updateStudentData(student);

                                // Check if the widget is still mounted before navigating
                                if(mounted) {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                    return ChallengeResultScreen(quizListResult: widget.quizList, totalScore: totalScore);
                                  }));
                                }
                              } catch(e) {
                                print("challenge_detail_screen: $e");
                              }
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
                          ));
                    },
                  ),
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

