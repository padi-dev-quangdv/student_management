import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:student_management/model/student.dart';

class DatabaseRepository {

  String? uid;

  DatabaseRepository({this.uid});

  // Collection reference
  final CollectionReference studentCollection = FirebaseFirestore.instance.collection("students");

  Future updateStudentData(Student student) async {
    return await studentCollection.doc(student.id).set({
      "id": student.id,
      "email" : student.email,
      "password" : student.password,
      "fullName" : student.fullName,
      "className" : student.className,
      "android" : student.android,
      "flutter" : student.flutter,
      "swift" : student.swift,
      "profileImageUrl": student.profileImageUrl
    });
  }

  // get student info from snapshot
  Student _studentDataFromSnapShot(DocumentSnapshot snapshot) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>;
    return Student(
        id: data["id"],
        email: data["email"],
        password: data["password"],
        fullName: data["fullName"],
        className: data["className"],
        android: data["android"],
        flutter: data["flutter"],
        swift: data["swift"],
        profileImageUrl: data["profileImageUrl"]);
  }

  // get user stream
  Stream<Student> get student {
    return studentCollection.doc(uid).snapshots().map((event) => _studentDataFromSnapShot(event));
  }

  // get list student from snapshot
  List<Student> _studentListFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.docs.map((value) {
      Map<String, dynamic>? data = value.data() as Map<String, dynamic>;
      return Student(
          id: data["id"],
          email: data["email"],
          password: data["password"],
          fullName: data["fullName"],
          className: data["className"],
          android: data["android"],
          flutter: data["flutter"],
          swift: data["swift"],
          profileImageUrl: data["profileImageUrl"]);
    }).toList();
  }

  // get list user stream
  Stream<List<Student>> get students {
    return studentCollection.snapshots().map(_studentListFromSnapShot);
  }

  // upload image to firebase
  Future<void> uploadImageToFirebase(File imageFile, Student student) async {
    try {
      String name = basename(imageFile.path);
      String imageName = "profile_image_${student.id}_$name";
      final storageReference = FirebaseStorage.instance.ref().child("profile_image/$imageName");
      final uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot storageTaskSnapshot = await uploadTask.whenComplete(() => null);

      String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      final currentStudent = student;
      currentStudent.profileImageUrl = downloadUrl;
      await updateStudentData(student);
      print("url: $downloadUrl");
    } catch(e) {
      print("upload image error: ${e.toString()}");
    }
  }
}