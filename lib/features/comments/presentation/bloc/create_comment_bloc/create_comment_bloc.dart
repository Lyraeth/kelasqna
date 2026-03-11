import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/kelasqna.dart';

part 'create_comment_bloc.freezed.dart';
part 'create_comment_event.dart';
part 'create_comment_state.dart';

class CreateCommentBloc extends Bloc<CreateCommentEvent, CreateCommentState> {
  final CreateCommentUseCase _createCommentUseCase;

  CreateCommentBloc(this._createCommentUseCase)
    : super(const CreateCommentState.initial()) {
    on<_CreateComment>(_onCreateComment);
  }

  Future<void> _onCreateComment(
    _CreateComment event,
    Emitter<CreateCommentState> emit,
  ) async {
    emit(const CreateCommentState.loading());

    final result = await _createCommentUseCase.call(
      event.questionId,
      content: event.content,
    );

    return result.match(
      (failure) => emit(CreateCommentState.failure(failure)),
      (CommentsEntity commentsEntity) =>
          emit(CreateCommentState.success(commentsEntity: commentsEntity)),
    );
  }
}
