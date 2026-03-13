import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/kelasqna.dart';

part 'edit_comment_bloc.freezed.dart';
part 'edit_comment_event.dart';
part 'edit_comment_state.dart';

class EditCommentBloc extends Bloc<EditCommentEvent, EditCommentState> {
  final EditCommentUseCase _editCommentUseCase;

  EditCommentBloc(this._editCommentUseCase)
    : super(const EditCommentState.initial()) {
    on<_EditComment>(_onEditComment);
  }

  Future<void> _onEditComment(
    _EditComment event,
    Emitter<EditCommentState> emit,
  ) async {
    emit(const EditCommentState.loading());

    final result = await _editCommentUseCase.call(
      event.questionId,
      event.commentId,
      content: event.content,
    );

    return result.match(
      (failure) => emit(EditCommentState.failure(failure)),
      (CommentsEntity commentsEntity) =>
          emit(EditCommentState.success(commentsEntity: commentsEntity)),
    );
  }
}
