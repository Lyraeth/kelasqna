import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/kelasqna.dart';

part 'delete_comment_bloc.freezed.dart';
part 'delete_comment_event.dart';
part 'delete_comment_state.dart';

class DeleteCommentBloc extends Bloc<DeleteCommentEvent, DeleteCommentState> {
  final DeleteCommentUseCase _deleteCommentUseCase;

  DeleteCommentBloc(this._deleteCommentUseCase)
    : super(const DeleteCommentState.initial()) {
    on<_DeleteComment>(_onDeleteComment);
  }

  Future<void> _onDeleteComment(
    _DeleteComment event,
    Emitter<DeleteCommentState> emit,
  ) async {
    emit(const DeleteCommentState.loading());

    await _deleteCommentUseCase.call(event.questionId, event.commentId);

    emit(const DeleteCommentState.success());
  }
}
