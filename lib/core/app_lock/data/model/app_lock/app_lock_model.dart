import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_lock_model.freezed.dart';
part 'app_lock_model.g.dart';

@freezed
abstract class AppLockModel with _$AppLockModel {
  const factory AppLockModel({
    @Default(false) bool isEnable,
    @Default(3) int lockAfterMinutes,
  }) = _AppLockModel;

  factory AppLockModel.fromJson(Map<String, dynamic> json) =>
      _$AppLockModelFromJson(json);
}
