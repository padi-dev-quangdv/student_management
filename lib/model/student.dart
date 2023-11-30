class Student {
  String id;
  String email;
  String password;
  String fullName;
  String className;
  double android;
  double flutter;
  double swift;
  String profileImageUrl;

  Student(
      {required this.id,
      required this.email,
      required this.password,
      required this.fullName,
      this.className = "empty",
      this.android = 0.0,
      this.flutter = 0.0,
      this.swift = 0.0,
      this.profileImageUrl = ""});

  factory Student.defaultStudent() {
    return Student(
        id: "-1",
        email: "email@example.com",
        password: "password",
        fullName: "user");
  }

  double getSummary() {
    return android + swift + flutter;
  }

  @override
  String toString() {
    return "$id - $email - $password - $fullName";
  }
}
