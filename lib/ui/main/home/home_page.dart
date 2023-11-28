import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:student_management/ui/component/text/large_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    double imageSliderHeight = MediaQuery.of(context).size.height / 4;
    double imageSliderWidth = MediaQuery.of(context).size.width * 4 / 5;
    List<String> imageUrls = [
      "https://intech.vietnamworks.com/media/gallery/2023/02/03/63dcc0393b26b.jpg",
      "https://vtcc.vn/wp-content/uploads/2023/02/3_94e7c97f5d.jpg",
      "https://yugasa.com/wp-content/uploads/2022/06/In-2022-Flutter-For-Web-A-Detailed-Guide-to-Developing-a-Flutter-Web-App-will-be-released.jpg"
    ];

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
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                height: double.infinity,
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
                              height: imageSliderHeight,
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
            ),
            Expanded(
                flex: 3,
                child: Container()
            )
          ],
        ),
      ),
    );
  }
}
