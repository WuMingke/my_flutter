import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter/demo/answer/data.dart';

part 'answer_event.dart';
part 'answer_state.dart';

class AnswerBloc extends Bloc<AnswerEvent, AnswerState> {
  AnswerBloc() : super(const AnswerState()) {
    on<AnswerEventInit>(_init);
    on<AnswerEventNext>(_next);
    on<AnswerEventSelect>(_select);
  }

  void _select(AnswerEventSelect event, Emitter<AnswerState> emit) {
    int selectIndex = event.selectIndex;
    // 当前的mCurrentState 就是第几题
    Map<int, int> m = Map.of(state.select);
    m[state.mCurrentState] = selectIndex;
    emit(
      state.copyWith(
        select: m,
      ),
    );
  }

  void _next(AnswerEventNext event, Emitter<AnswerState> emit) {
    int nextState = state.mCurrentState + 1;
    String btnContent = "下一题";
    if (nextState == 3) {
      btnContent = "完成";
    }
    emit(
      state.copyWith(
        mCurrentState: nextState,
        btnContent: btnContent,
      ),
    );
  }

  void _init(AnswerEventInit event, Emitter<AnswerState> emit) {
    RspCheckQuestion rsp = Data().getData(); // 模拟接口数据
    String titleRole = "主播";
    if (rsp.role == 2) {
      titleRole = "主持人";
    } else if (rsp.role == 3) {
      titleRole = "家族长";
    } else if (rsp.role == 4) {
      titleRole = "技能者";
    }
    String title = "成为$titleRole申请";
    List<String> initStr = ["为确保您已理解并会遵守$titleRole公约内容，您还需回答3道题目。"];
    if (rsp.is_need_check) {
      initStr.add("答案全部正确才可通过。");
    }
    initStr.add("答题通过后，工作人员会尽快为您进行审核，审核通过后可成为主播，获得身份对应的特权。");

    List<CheckQuestion> q = rsp.check_question;
    Map<int, int> answer = {};
    for (int i = 0; i < q.length; i++) {
      answer[i + 1] = q[i].correctAnswerIndex;
    }
    emit(
      state.copyWith(
        title: title,
        initTextList: initStr,
        correctAnswer: answer,
        q: q,
      ),
    );
  }
}
