part of 'answer_bloc.dart';

abstract class AnswerEvent extends Equatable {
  const AnswerEvent();
}

class AnswerEventInit extends AnswerEvent {
  @override
  List<Object?> get props => [];
}

class AnswerEventNext extends AnswerEvent {
  @override
  List<Object?> get props => [];
}
