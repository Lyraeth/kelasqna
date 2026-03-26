import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_lock_entity.freezed.dart';

@freezed
abstract class AppLockEntity with _$AppLockEntity {
  const factory AppLockEntity({
    required bool isEnable,
    required int lockAfterMinutes,
  }) = _AppLockEntity;
}
