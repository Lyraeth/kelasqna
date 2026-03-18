import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/kelasqna.dart';

part 'notification_bloc.freezed.dart';
part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final FetchNotificationsUseCase _fetchNotificationsUseCase;
  final MarkAsReadUseCase _markAsReadUseCase;
  final MarkAllAsReadUseCase _markAllAsReadUseCase;

  NotificationBloc(
    this._fetchNotificationsUseCase,
    this._markAsReadUseCase,
    this._markAllAsReadUseCase,
  ) : super(const NotificationState.initial()) {
    on<_Started>(_onStarted);
    on<_LoadPage>(_onLoadPage);
    on<_MarkAsRead>(_onMarkAsRead);
    on<_MarkAllRead>(_onMarkAllRead);
  }

  Future<void> _onStarted(
    _Started event,
    Emitter<NotificationState> emit,
  ) async {
    if (!event.forceRefresh && state is _HasData) return;
    await _fetchPage(1, emit);
  }

  Future<void> _onLoadPage(
    _LoadPage event,
    Emitter<NotificationState> emit,
  ) async {
    await _fetchPage(event.page, emit);
  }

  Future<void> _fetchPage(int page, Emitter<NotificationState> emit) async {
    emit(NotificationState.loading(currentPage: page));

    final result = await _fetchNotificationsUseCase.call(page: page);

    return result.match(
      (failure) => emit(NotificationState.failure(failure)),
      (paginated) => paginated.data.isEmpty
          ? emit(NotificationState.emptyData())
          : emit(
              NotificationState.hasData(
                listNotification: paginated.data,
                currentPage: paginated.currentPage,
                totalPages: paginated.totalPages,
              ),
            ),
    );
  }

  Future<void> _onMarkAsRead(_MarkAsRead event, Emitter emit) async {
    final result = await _markAsReadUseCase.call(id: event.id);

    return result.match(
      (failure) => emit(NotificationState.failure(failure)),
      (res) => add(const NotificationEvent.started(forceRefresh: true)),
    );
  }

  Future<void> _onMarkAllRead(_MarkAllRead event, Emitter emit) async {
    final result = await _markAllAsReadUseCase.call();

    return result.match(
      (failure) => emit(NotificationState.failure(failure)),
      (res) => add(const NotificationEvent.started(forceRefresh: true)),
    );
  }
}
