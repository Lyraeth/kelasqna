import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/kelasqna.dart';

part 'create_question_bloc.freezed.dart';
part 'create_question_event.dart';
part 'create_question_state.dart';

class CreateQuestionBloc
    extends Bloc<CreateQuestionEvent, CreateQuestionState> {
  final CreateQuestionUseCase _createQuestionUseCase;

  CreateQuestionBloc(this._createQuestionUseCase)
    : super(const CreateQuestionState.initial()) {
    on<_CreateQuestion>(_onCreateQuestion);
  }

  Future<void> _onCreateQuestion(
    _CreateQuestion event,
    Emitter<CreateQuestionState> emit,
  ) async {
    emit(const CreateQuestionState.loading());

    final QuestionParams params = QuestionParams(
      title: event.questionParams.title,
      content: event.questionParams.content,
    );

    final result = await _createQuestionUseCase.call(params);

    return result.match(
      (failure) => emit(CreateQuestionState.failure(failure)),
      (QuestionEntity questionEntity) =>
          emit(CreateQuestionState.success(questionEntity: questionEntity)),
    );
  }
}
