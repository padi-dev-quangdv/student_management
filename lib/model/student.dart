class Student {
  String id;
  String email;
  String password;
  String fullName;
  String className;
  double math;
  double physic;
  double english;
  String profileImageUrl;

  Student(
      {required this.id,
      required this.email,
      required this.password,
      required this.fullName,
      this.className = "empty",
      this.math = 0.0,
      this.physic = 0.0,
      this.english = 0.0,
      this.profileImageUrl = ""});

  factory Student.defaultStudent() {
    return Student(
        id: "-1",
        email: "email@example.com",
        password: "password",
        fullName: "user");
  }

  double getSummary() {
    return math + english + physic;
  }

  @override
  String toString() {
    return "$id - $email - $password - $fullName";
  }
}
