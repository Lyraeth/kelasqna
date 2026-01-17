import 'package:kelasqna/core/app/bloc/app_bloc.dart';
import 'package:kelasqna/core/internationalization/domain/usecase/intl_use_case.dart';
import 'package:kelasqna/core/shared/constant.dart';
import 'package:kelasqna/core/theme/domain/usecase/theme_use_case.dart';

void initAppDI() {
  sI.registerFactory<AppBloc>(
    () => AppBloc(sI<IntlUseCase>(), sI<ThemeUseCase>()),
  );
}
