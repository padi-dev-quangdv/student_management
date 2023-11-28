import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_management/model/course.dart';

class CourseRepository {
  String? id;

  CourseRepository({this.id});

  final CollectionReference courseCollection =
      FirebaseFirestore.instance.collection("courses");

  Future updateCourseData(Course course) async {
    return await courseCollection.doc(course.id).set({
      "id": course.id,
      "name": course.name,
      "link": course.link,
      "imageUrl": course.imageUrl,
      "desc": course.desc
    });
  }

  // get course data from snapshot
  Course _courseDataFromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>;
    return Course(
        id: data["id"],
        name: data["name"],
        link: data["link"],
        imageUrl: data["imageUrl"],
        desc: data["desc"]
    );
  }

  // get course stream
  Stream<Course> get course {
    return courseCollection.doc(id).snapshots().map(_courseDataFromSnapshot);
  }

  // get list course from snapshot
  List<Course> _courseListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((value) {
      Map<String, dynamic>? data = value.data() as Map<String, dynamic>;
      return Course(
          id: data["id"],
          name: data["name"],
          link: data["link"],
          imageUrl: data["imageUrl"],
          desc: data["desc"]
      );
    }).toList();
  }

  // get course list stream
  Stream<List<Course>> get courses {
    print("here");
    return courseCollection.snapshots().map(_courseListFromSnapshot);
  }
}
