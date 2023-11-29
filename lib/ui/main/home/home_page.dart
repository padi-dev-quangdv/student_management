import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:student_management/ui/component/text/large_text.dart';
import 'package:student_management/ui/main/home/list_course.dart';
import 'package:student_management/ui/main/home/list_news.dart';
import 'package:student_management/ui/main/settings/settings_screen.dart';
import 'package:student_management/utils/colors.dart';
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
    double courseHeight = availabilityHeight * 3 / 10;

    return Scaffold(
      appBar: AppBar(
        title: LargeText(text: "Home",size: 20, fontWeight: FontWeight.w700),
        actions: [
          GestureDetector(
              onTap: () {
                showModalBottomSheet(context: context, builder: (BuildContext context) {
                      return SettingsScreen();
                });
              },
              child: const Padding(
                  padding: EdgeInsets.only(right: 24),
                  child: Icon(Icons.settings)
              )
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: courseHeight,
              width: double.infinity,
              child: CarouselSlider.builder(
                  itemCount: imageUrls.length,
                  itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
                    return Container(
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
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: AppColors.infoBorder
              ),
              height: courseHeight,
              width: double.infinity,
              child: const ListCourse(),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              height: courseHeight,
              child: const ListNews(),
            )
          ],
        ),
      ),
    );
  }
}