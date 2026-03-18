import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:kelasqna/kelasqna.dart';

Future<void> initConnectivityDI() async {
  sI.registerLazySingleton<Connectivity>(() => Connectivity());

  sI.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker.createInstance(),
  );

  sI.registerLazySingleton<ConnectivityService>(
    () => ConnectivityService(
      connectivity: sI<Connectivity>(),
      internetConnectionChecker: sI<InternetConnectionChecker>(),
    ),
  );

  sI.registerLazySingleton<ConnectivityBloc>(
    () =>
        ConnectivityBloc(connectivityService: sI<ConnectivityService>())
          ..add(ConnectivityEvent.started()),
  );
}
