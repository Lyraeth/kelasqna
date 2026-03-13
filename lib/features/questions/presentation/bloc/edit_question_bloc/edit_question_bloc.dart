import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/kelasqna.dart';

part 'edit_question_bloc.freezed.dart';
part 'edit_question_event.dart';
part 'edit_question_state.dart';

class EditQuestionBloc extends Bloc<EditQuestionEvent, EditQuestionState> {
  final EditQuestionUseCase _editQuestionUseCase;

  EditQuestionBloc(this._editQuestionUseCase)
    : super(const EditQuestionState.initial()) {
    on<_EditQuestion>(_onEditQuestion);
  }

  Future<void> _onEditQuestion(
    _EditQuestion event,
    Emitter<EditQuestionState> emit,
  ) async {
    emit(EditQuestionState.loading());

    final params = event.editQuestionParams;

    final result = await _editQuestionUseCase.call(
      event.id,
      editQuestionParams: params,
    );

    return result.match(
      (failure) => emit(EditQuestionState.failure(failure)),
      (question) => emit(EditQuestionState.success(questionEntity: question)),
    );
  }
}
