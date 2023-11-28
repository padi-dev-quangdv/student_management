import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:student_management/model/course.dart';
import 'package:student_management/repository/course_repository.dart';
import 'package:student_management/ui/component/text/large_text.dart';
import 'package:student_management/utils/screen_util.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    List<String> imageUrls = [
      "https://intech.vietnamworks.com/media/gallery/2023/02/03/63dcc0393b26b.jpg",
      "https://vtcc.vn/wp-content/uploads/2023/02/3_94e7c97f5d.jpg",
      "https://yugasa.com/wp-content/uploads/2022/06/In-2022-Flutter-For-Web-A-Detailed-Guide-to-Developing-a-Flutter-Web-App-will-be-released.jpg"
    ];

    final availabilityHeight = ScreenUtils.getRemainingHeight(context);
    double sliderHeight = availabilityHeight * 4 / 10;
    double courseHeight = availabilityHeight * 3 / 10;

    return Scaffold(
      appBar: AppBar(
        title: LargeText(text: "Home",size: 20, fontWeight: FontWeight.w700),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              height: sliderHeight,
              width: double.infinity,
              child: CarouselSlider.builder(
                  itemCount: imageUrls.length,
                  itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
                    return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14.0),
                          // Adjust based on border width
                          child: Image.network(
                            imageUrls[itemIndex],
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        )
                      );
                    },
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 0.95,
                    aspectRatio: 2.0
                  )
              )
            ),
            LargeText(text: "Courses"),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              height: courseHeight,
              width: double.infinity,
              child: const ListCourse(),
            ),
          ],
        ),
      ),
    );
  }
}

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
                            image:
                                "https://intech.vietnamworks.com/media/gallery/2023/02/03/63dcc0393b26b.jpg",
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
