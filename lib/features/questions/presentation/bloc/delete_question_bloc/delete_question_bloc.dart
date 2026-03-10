import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/kelasqna.dart';

part 'delete_question_bloc.freezed.dart';
part 'delete_question_event.dart';
part 'delete_question_state.dart';

class DeleteQuestionBloc
    extends Bloc<DeleteQuestionEvent, DeleteQuestionState> {
  final DeleteQuestionUseCase _deleteQuestionUseCase;

  DeleteQuestionBloc(this._deleteQuestionUseCase)
    : super(const DeleteQuestionState.initial()) {
    on<_DeleteQuestion>(_onDeleteQuestion);
  }

  Future<void> _onDeleteQuestion(
    _DeleteQuestion event,
    Emitter<DeleteQuestionState> emit,
  ) async {
    emit(DeleteQuestionState.loading());

    await _deleteQuestionUseCase.call(id: event.id);

    emit(DeleteQuestionState.success());
  }
}
