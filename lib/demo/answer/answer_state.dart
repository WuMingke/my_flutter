part of 'answer_bloc.dart';

class AnswerState extends Equatable {
  final String title; // 标题
  final List<String> initTextList; // 提示语
  final Map<int, int> select; // 对应页面选择的题号
  final Map<int, int> correctAnswer; // 对应页面正确的答案
  final String btnContent; // 按钮文案
  final int mCurrentState; // 当前进度：0-未答题，1-第一题，2-第二题，3-第三题or提交了答题
  final int source; // 用于数据上报，1-创建房间，2-积分商城
  final List<CheckQuestion> q; // 问题列表

  const AnswerState({
    this.title = "",
    this.initTextList = const [],
    this.select = const {1: -1, 2: -1, 3: -1}, // -1表示未选择
    this.btnContent = "开始答题",
    this.mCurrentState = 0,
    this.source = 1,
    this.correctAnswer = const {},
    this.q = const [],
  });

  AnswerState copyWith({
    String? title,
    List<String>? initTextList,
    Map<int, int>? select,
    String? btnContent,
    int? mCurrentState,
    int? source,
    Map<int, int>? correctAnswer,
    List<CheckQuestion>? q,
  }) {
    return AnswerState(
      title: title ?? this.title,
      initTextList: initTextList ?? this.initTextList,
      select: select ?? this.select,
      btnContent: btnContent ?? this.btnContent,
      mCurrentState: mCurrentState ?? this.mCurrentState,
      source: source ?? this.source,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      q: q ?? this.q,
    );
  }

  @override
  List<Object?> get props => [
        title,
        initTextList,
        select,
        btnContent,
        mCurrentState,
        source,
        correctAnswer,
        q,
      ];
}
