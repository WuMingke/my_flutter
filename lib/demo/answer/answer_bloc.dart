import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'answer_event.dart';
part 'answer_state.dart';

class AnswerBloc extends Bloc<AnswerEvent, AnswerState> {
  AnswerBloc() : super(const AnswerState()) {
    on<AnswerEventInit>(_init);
  }

  void _init(AnswerEventInit event, Emitter<AnswerState> emit) {
    String title = "成为主播申请";
    List<String> initStr = [
      "为确保您已理解并会遵守主播公约内容，您还需回答3道题目。",
      "答案全部正确才可通过。",
      "答题通过后，工作人员会尽快为您进行审核，审核通过后可成为主播，获得身份对应的特权。",
    ];
    emit(
      state.copyWith(
        title: title,
        initTextList: initStr,
      ),
    );
  }
}
