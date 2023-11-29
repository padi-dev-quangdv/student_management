import 'package:flutter/material.dart';
import 'package:student_management/model/course.dart';
import 'package:student_management/repository/course_repository.dart';
import 'package:student_management/ui/component/text/large_text.dart';
import 'package:student_management/utils/screen_util.dart';

class ListCourse extends StatelessWidget {

  const ListCourse({super.key});

  @override
  Widget build(BuildContext context) {
    final availabilityHeight = ScreenUtils.getRemainingHeight(context);
    double courseEdge = availabilityHeight / 5;

    return StreamBuilder<List<Course>>(
        stream: CourseRepository().courses,
        builder: (context, snapshot) {
          // return empty list if snapshot has no data
          List<Course> courses = snapshot.hasData ? snapshot.data ?? [] : [];

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: courses.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  GestureDetector(
                    onTap: () {
                      //todo: navigate to detail course screen
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      height: courseEdge,
                      width: courseEdge,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: FadeInImage.assetNetwork(
                            placeholder: "assets/image/img_loading.png",
                            image: courses[index].imageUrl,
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  LargeText(text: courses[index].name)
                ],
              );
            },
          );
        });
  }
}