part of 'answer_bloc.dart';

class AnswerState extends Equatable {
  final String title;
  final List<String> initTextList;
  final Map<int, int> select; // 对应页面选择的题号
  final Map<int, int> answer; // 对应页面选择的答案

  const AnswerState({
    this.title = "",
    this.initTextList = const [],
    this.select = const {},
    this.answer = const {},
  });

  AnswerState copyWith({
    String? title,
    List<String>? initTextList,
    Map<int, int>? select,
    Map<int, int>? answer,
  }) {
    return AnswerState(
      title: title ?? this.title,
      initTextList: initTextList ?? this.initTextList,
      select: select ?? this.select,
      answer: answer ?? this.answer,
    );
  }

  @override
  List<Object?> get props => [
        title,
        initTextList,
      ];
}
