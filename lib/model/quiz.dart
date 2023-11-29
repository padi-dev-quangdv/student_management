class Quiz {
  String id;
  String question;
  String answer1;
  String answer2;
  String answer3;
  String answer4;
  int correctIndexAnswer;
  String level;
  String typeQuiz;

  Quiz(
      {required this.id,
      required this.question,
      required this.answer1,
      required this.answer2,
      required this.answer3,
      required this.answer4,
      required this.correctIndexAnswer,
      required this.level,
      required this.typeQuiz});
}
