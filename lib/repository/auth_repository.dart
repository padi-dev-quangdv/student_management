import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_management/model/local_user.dart';
import 'package:student_management/model/student.dart';
import 'package:student_management/repository/database_repository.dart';

class AuthRepository {
  final  FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on UserFirebase
  LocalUser? _getUserFromFirebaseUser(User? user)   {
    return user != null ? LocalUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<LocalUser?> get user {
    return _auth.authStateChanges().map(_getUserFromFirebaseUser);
  }

  // register with email &b password
  Future registerWithEmailAndPassword(String email, String password, String fullName) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      if(user != null) {
        Student student = Student(id: user.uid, email: email, password: password, fullName: fullName);
        await DatabaseRepository(uid: user.uid).updateStudentData(student);
      }

      return _getUserFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _getUserFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // reset password
  Future<bool> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch(e) {
      print(e.toString());
      return false;
    }
  }
}