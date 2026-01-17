import 'package:kelasqna/core/internationalization/data/datasources/intl_local_data_source.dart';
import 'package:kelasqna/core/internationalization/data/repository/intl_repository_impl.dart';
import 'package:kelasqna/core/internationalization/domain/repository/intl_repository.dart';
import 'package:kelasqna/core/internationalization/domain/usecase/intl_use_case.dart';
import 'package:kelasqna/core/shared/constant.dart';

void initIntlDI() {
  sI.registerLazySingleton<IntlRepository>(
    () => IntlRepositoryImpl(sI<IntlLocalDataSource>()),
  );

  sI.registerLazySingleton<IntlUseCase>(
    () => IntlUseCase(sI<IntlRepository>()),
  );

  sI.registerLazySingleton<IntlLocalDataSource>(
    () => IntlLocalDataSourceImpl(),
  );
}
