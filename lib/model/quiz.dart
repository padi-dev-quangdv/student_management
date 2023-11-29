class Quiz {
  String id;
  String question;
  String answer1;
  String answer2;
  String answer3;
  String answer4;
  String correctAnswer;
  String level;
  String typeQuiz;
  String selectedAnswer;

  Quiz(
      {required this.id,
      required this.question,
      required this.answer1,
      required this.answer2,
      required this.answer3,
      required this.answer4,
      required this.correctAnswer,
      required this.level,
      required this.typeQuiz,
      this.selectedAnswer = ""});
}
