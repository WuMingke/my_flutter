class Data {
  Data._internal();

  factory Data() => _instance;

  static late final Data _instance = Data._internal();

  RspCheckQuestion getData() {
    CheckQuestion q1 = CheckQuestion(
      question_id: 0,
      correctAnswerIndex: 1,
      answer: ["答案1-1", "答案1-2", "答案1-3"],
      title: "问题1",
    );
    CheckQuestion q2 = CheckQuestion(
      question_id: 1,
      correctAnswerIndex: 1,
      answer: ["答案2-1", "答案2-2", "答案2-3"],
      title: "问题2问题2问题2问题2问题2问题2",
    );
    CheckQuestion q3 = CheckQuestion(
      question_id: 2,
      correctAnswerIndex: 1,
      answer: ["答案3-1", "答案3-2", "答案3-3"],
      title: "问题3",
    );

    List<CheckQuestion> q = [q1, q2, q3];
    return RspCheckQuestion(
      is_need_check: true,
      role: 2,
      check_question: q,
    );
  }
}

class RspCheckQuestion {
  bool is_need_check;
  int role;
  List<CheckQuestion> check_question;

  RspCheckQuestion({
    required this.is_need_check,
    required this.role,
    required this.check_question,
  });
}

class CheckQuestion {
  int question_id;
  int correctAnswerIndex;
  List<String> answer;
  String title;

  CheckQuestion({
    required this.question_id,
    required this.correctAnswerIndex,
    required this.answer,
    required this.title,
  });
}
