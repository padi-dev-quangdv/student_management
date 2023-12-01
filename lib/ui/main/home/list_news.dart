import 'package:flutter/material.dart';
import 'package:student_management/model/news.dart';
import 'package:student_management/repository/new_repository.dart';
import 'package:student_management/ui/component/text/large_text.dart';
import 'package:student_management/ui/component/text/medium_text.dart';
import 'package:url_launcher/url_launcher.dart';

class ListNews extends StatelessWidget {
  const ListNews({super.key});

  @override
  Widget build(BuildContext context) {

    NewsRepository newsRepository = NewsRepository();

    return StreamBuilder(
        stream: NewsRepository().newsList,
        builder: (context, snapshot) {
          // return empty list if snapshot has no data
          List<News> newsList = snapshot.hasData ? snapshot.data ?? [] : [];
          print("NewsList: ${newsList.length}");

          return ListView.builder(
            itemCount: newsList.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () async {
                  final Uri url = Uri.parse(newsList[index].link);
                  try {
                    var currentItem = newsList[index];
                    currentItem.views++;
                    await newsRepository.updateNewsData(currentItem);
                    await launchUrl(url);
                  } catch(e) {
                    print("Error open url: $e");
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 60,
                            width: 100,
                            child: FadeInImage.assetNetwork(
                                placeholder: "assets/image/img_loading.png",
                                image: newsList[index].imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Flexible(
                              child: LargeText(
                            text: newsList[index].title,
                            maxLines: 2,
                          ))
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(child: Row(
                            children: [
                              const Icon(Icons.access_time_sharp),
                              const SizedBox(width: 4),
                              MediumText(text: newsList[index].duration)
                            ],
                          )),
                          Expanded(child: Row(
                            children: [
                              MediumText(text: "Views: "),
                              MediumText(text: newsList[index].views.toString())
                            ],
                          )),
                          const Expanded(child: SizedBox())
                        ],
                      ),
                      const Divider()
                    ],
                  ),
                ),
              );
            },
          );
        }
    );
  }
}
