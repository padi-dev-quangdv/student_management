import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_management/model/news.dart';

class NewsRepository {

  String? id;

  NewsRepository({this.id});

  final CollectionReference newsCollection = FirebaseFirestore.instance.collection("news");

  Future updateNewsData(News news) async {
    return await newsCollection.doc(news.id).set({
      "id": news.id,
      "title": news.title,
      "link": news.link,
      "duration": news.duration,
      "views": news.views,
      "imageUrl": news.imageUrl
    });
  }

  // get new data from snapshot
  News _newsDataFromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>;
    return News(
        id: data["id"],
        title: data["title"],
        link: data["link"],
        duration: data["duration"],
        views: data["views"],
        imageUrl: data["imageUrl"]);
  }

  // get new stream
  Stream<News> get news {
    return newsCollection.doc(id).snapshots().map(_newsDataFromSnapshot);
  }

  // get list news from snapshot
  List<News> _newsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((value) {
      Map<String, dynamic>? data = value.data() as Map<String, dynamic>;
      return News(
          id: data["id"],
          title: data["title"],
          link: data["link"],
          duration: data["duration"],
          views: data["views"],
          imageUrl: data["imageUrl"]);
    }).toList();
  }

  // get list news stream
  Stream<List<News>> get newsList {
    return newsCollection.snapshots().map(_newsListFromSnapshot);
  }
}