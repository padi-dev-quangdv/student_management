import 'package:flutter/material.dart';
import 'package:student_management/model/student.dart';
import 'package:student_management/repository/database_repository.dart';
import 'package:student_management/ui/component/text/large_text.dart';
import 'package:student_management/ui/component/text/medium_text.dart';
import 'package:student_management/utils/colors.dart';

class RankPage extends StatefulWidget {
  const RankPage({super.key});

  @override
  State<RankPage> createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> {
  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
        stream: DatabaseRepository().students,
        builder: (context, snapshot) {
          // return empty list if snapshot has no data
          List<Student> students = snapshot.hasData ? snapshot.data ?? [] : [];
          students.sort( (s1, s2) {
            return -s1.getSummary().compareTo(s2.getSummary());  // character "-": sort by descending
          });

          return Scaffold(
            appBar: AppBar(
              title: LargeText(text: "Score rankings", size: 20, fontWeight: FontWeight.w700),
            ),
            body: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: TopRankingWidget(
                                currentStudent: students[1],
                                heightFlexRanking: 4,
                                textNumberRanking: "2",
                                color: AppColors.successHover)
                        ),
                        Expanded(
                            flex: 1,
                            child: TopRankingWidget(
                                currentStudent: students[0],
                                heightFlexRanking: 6,
                                textNumberRanking: "1",
                                color: AppColors.dangerHover)
                        ),
                        Expanded(
                            flex: 1,
                            child: TopRankingWidget(
                                currentStudent: students[2],
                                heightFlexRanking: 2,
                                textNumberRanking: "3",
                                color: AppColors.warningMain)
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                   //height: listViewHeight,
                    padding: const EdgeInsets.all(8),
                    child: ListView.builder(
                        itemCount: students.length,
                        itemBuilder: (BuildContext context, int index) {
                          return RankField(
                              student: students[index], index: index);
                        }),
                  ),
                ),
              ]
            ),
          );
        });
  }
}

class RankField extends StatefulWidget {
  final Student student;
  final int index;

  const RankField({super.key, required this.student, required this.index});

  @override
  State<RankField> createState() => _RankFieldState();
}

class _RankFieldState extends State<RankField> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {

    Student student = widget.student;
    int index = widget.index;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Row(
              children: [
                Expanded(flex: 1, child: MediumText(text: (index + 1).toString())),
                Expanded(flex: 2, child: Center(
                      child: ClipOval(
                        child: Container(
                          color: Colors.blue[100],
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(24),
                            child: student.profileImageUrl.isEmpty
                                ? const Icon(Icons.person,
                                    size: 24, color: AppColors.infoMain)
                                : FadeInImage.assetNetwork(
                                    image: student.profileImageUrl,
                                    placeholder: "assets/image/img_loading.png",
                                    fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    )),
                Expanded(flex: 7, child: LargeText(text: student.fullName)),
                Expanded(
                    child: Align(
                  alignment: Alignment.centerRight,
                  child: isExpanded
                      ? const Icon(Icons.arrow_drop_up_outlined)
                      : const Icon(Icons.arrow_drop_down_outlined),
                ))
              ],
            ),
          ),
          if(isExpanded) ... [
            Card(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Column(
                  children: [
                    DetailRankingField(title: "Name:", content: student.fullName),
                    DetailRankingField(title: "Class:", content: student.className),
                    DetailRankingField(title: "Math:", content: student.math.toString()),
                    DetailRankingField(title: "Physic:", content: student.physic.toString()),
                    DetailRankingField(title: "English:", content: student.english.toString()),
                  ],
                ),
              ),
            )
          ]
        ],
      ),
    );
  }
}

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

class TopRankingWidget extends StatelessWidget {

  final Student currentStudent;
  final int heightFlexRanking;
  final String textNumberRanking;
  final Color color;

  const TopRankingWidget(
      {super.key,
      required this.currentStudent,
      required this.heightFlexRanking,
      required this.textNumberRanking,
      required this.color});

  @override
  Widget build(BuildContext context) {
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
