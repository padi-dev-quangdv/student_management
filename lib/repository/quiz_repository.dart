import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_management/model/quiz.dart';

class QuizRepository {

  final CollectionReference quizCollection = FirebaseFirestore.instance
      .collection("quiz");

  // get list quiz from snapshot
  List<Quiz> _quizListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((value) {
      Map<String, dynamic>? data = value.data() as Map<String, dynamic>;
      return Quiz(id: data["id"],
          question: data["question"],
          answer1: data["answer1"],
          answer2: data["answer2"],
          answer3: data["answer3"],
          answer4: data["answer4"],
          correctAnswer: data["correctAnswer"],
          level: data["level"],
          typeQuiz: data["typeQuiz"]);
    }).toList();
  }

  // get list quiz stream
  Stream<List<Quiz>> get quizList {
    return quizCollection.snapshots().map(_quizListFromSnapshot);
  }
}