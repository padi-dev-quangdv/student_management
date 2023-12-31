import 'package:flutter/material.dart';
import 'package:student_management/model/quiz.dart';
import 'package:student_management/repository/quiz_repository.dart';
import 'package:student_management/ui/component/text/large_text.dart';
import 'package:student_management/ui/main/challenge/challenge_detail_screen.dart';
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

    return StreamBuilder(
        stream: QuizRepository().quizList,
        builder: (context, snapshot) {

          List<Quiz> quizList = snapshot.hasData ? snapshot.data ?? [] : [];
          print("fucK: ${quizList.length}");

          return  Scaffold(
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
                      onEasyClick: () {
                        List<Quiz> easyAndroidList = quizList
                            .where((quiz) => quiz.level =="easy" && quiz.typeQuiz == "android")
                            .toList();
                        easyAndroidList.shuffle();
                        var firstFive = easyAndroidList.sublist(0,5);
                        for (var quiz in firstFive) {
                          quiz.selectedAnswer = "";
                        }
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return ChallengeDetailScreen(quizList: firstFive,buttonColor: Colors.green);
                        }));
                      },
                      onMediumClick: () {
                        List<Quiz> mediumAndroidList = quizList
                            .where((quiz) => quiz.level =="medium" && quiz.typeQuiz == "android")
                            .toList();
                        mediumAndroidList.shuffle();
                        var firstFive = mediumAndroidList.sublist(0,5);
                        for (var quiz in firstFive) {
                          quiz.selectedAnswer = "";
                        }
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return ChallengeDetailScreen(quizList: firstFive, buttonColor: Colors.green);
                        }));
                      },
                      onHardClick: () {
                        List<Quiz> hardAndroidList = quizList
                            .where((quiz) => quiz.level =="hard" && quiz.typeQuiz == "android")
                            .toList();
                        hardAndroidList.shuffle();
                        var firstFive = hardAndroidList.sublist(0,5);
                        for (var quiz in firstFive) {
                          quiz.selectedAnswer = "";
                        }
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return ChallengeDetailScreen(quizList: firstFive, buttonColor: Colors.green);
                        }));
                      },
                    ),
                    ChallengeCategory(
                      title: "Flutter",
                      containerHeight: eachPartHeight,
                      imagePath: "assets/image/flutter_logo.png",
                      imageEdge: imageEdge,
                      mainColor: Colors.blue,
                      onEasyClick: () {
                        List<Quiz> easyFlutterList = quizList
                            .where((quiz) => quiz.level =="easy" && quiz.typeQuiz == "flutter")
                            .toList();
                        easyFlutterList.shuffle();
                        var firstFive = easyFlutterList.sublist(0,5);
                        for (var quiz in firstFive) {
                          quiz.selectedAnswer = "";
                        }
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return ChallengeDetailScreen(quizList: firstFive,buttonColor: Colors.blue);
                        }));
                      },
                      onMediumClick: () {
                        List<Quiz> mediumFlutterList = quizList
                            .where((quiz) => quiz.level =="medium" && quiz.typeQuiz == "flutter")
                            .toList();
                        mediumFlutterList.shuffle();
                        var firstFive = mediumFlutterList.sublist(0, 5);
                        for (var quiz in firstFive) {
                          quiz.selectedAnswer = "";
                        }
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return ChallengeDetailScreen(quizList: firstFive,buttonColor: Colors.blue);
                        }));
                      },
                      onHardClick: () {
                        List<Quiz> hardFlutterList = quizList
                            .where((quiz) => quiz.level =="hard" && quiz.typeQuiz == "flutter")
                            .toList();
                        hardFlutterList.shuffle();
                        var firstFive = hardFlutterList.sublist(0, 5);
                        for (var quiz in firstFive) {
                          quiz.selectedAnswer = "";
                        }
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return ChallengeDetailScreen(quizList: firstFive,buttonColor: Colors.blue);
                        }));
                      },
                    ),
                    ChallengeCategory(
                      title: "Swift",
                      containerHeight: eachPartHeight,
                      imagePath: "assets/image/swift_logo.png",
                      imageEdge: imageEdge,
                      mainColor: Colors.deepOrange,
                      onEasyClick: () {
                        List<Quiz> easySwiftList = quizList
                            .where((quiz) => quiz.level =="easy" && quiz.typeQuiz == "swift")
                            .toList();
                        easySwiftList.shuffle();
                        var firstFive = easySwiftList.sublist(0,5);
                        for (var quiz in firstFive) {
                          quiz.selectedAnswer = "";
                        }
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return ChallengeDetailScreen(quizList: firstFive,buttonColor: Colors.deepOrange);
                        }));
                      },
                      onMediumClick: () {
                        List<Quiz> mediumSwiftList = quizList
                            .where((quiz) => quiz.level =="medium" && quiz.typeQuiz == "swift")
                            .toList();
                        mediumSwiftList.shuffle();
                        var firstFive = mediumSwiftList.sublist(0,5);
                        for (var quiz in firstFive) {
                          quiz.selectedAnswer = "";
                        }
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return ChallengeDetailScreen(quizList: firstFive,buttonColor: Colors.deepOrange);
                        }));
                      },
                      onHardClick: () {
                        List<Quiz> hardSwiftList = quizList
                            .where((quiz) => quiz.level =="hard" && quiz.typeQuiz == "swift")
                            .toList();
                        hardSwiftList.shuffle();
                        var firstFive = hardSwiftList.sublist(0,5);
                        for (var quiz in firstFive) {
                          quiz.selectedAnswer = "";
                        }
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return ChallengeDetailScreen(quizList: firstFive,buttonColor: Colors.deepOrange);
                        }));
                      },
                    )
                  ],
                )),
          );
        }
    );
  }
}

class ChallengeCategory extends StatelessWidget {

  final String title;
  final double containerHeight;
  final String imagePath;
  final double imageEdge;
  final Color mainColor;
  final Function()? onEasyClick;
  final Function()? onMediumClick;
  final Function()? onHardClick;

  const ChallengeCategory(
      {super.key,
      required this.title,
      required this.containerHeight,
      required this.imagePath,
      required this.imageEdge,
      required this.mainColor,
      required this.onEasyClick,
      required this.onMediumClick,
      required this.onHardClick});

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
                        GestureDetector(
                            onTap: onEasyClick,
                            child: ChallengeField(level: "Easy", textColor: mainColor)),
                        GestureDetector(
                            onTap: onMediumClick,
                            child: ChallengeField(level: "Medium", textColor: mainColor)),
                        GestureDetector(
                            onTap: onHardClick,
                            child: ChallengeField(level: "Hard", textColor: mainColor)),
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


