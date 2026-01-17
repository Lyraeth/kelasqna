import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:kelasqna/app_bloc_observer.dart';
import 'package:kelasqna/core/api/api_constant.dart';
import 'package:kelasqna/core/api/failures/api_client_di.dart';
import 'package:kelasqna/core/app/app_di.dart';
import 'package:kelasqna/core/app/kelasqna_app.dart';
import 'package:kelasqna/core/internationalization/intl_di.dart';
import 'package:kelasqna/core/internationalization/intl_translation.dart';
import 'package:kelasqna/core/network/network_di.dart';
import 'package:kelasqna/core/shared/constant.dart';
import 'package:kelasqna/core/storage/hive/hive_init.dart';
import 'package:kelasqna/core/theme/theme_di.dart';
import 'package:kelasqna/features/auth/auth_di.dart';
import 'package:kelasqna/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> initializeApp() async {
  /// Ensure that the Flutter binding is initialized before
  /// any Flutter-specific code.
  WidgetsFlutterBinding.ensureInitialized();

  /// Load the .env file.
  await dotenv.load(fileName: ".env");

  /// Initialize storage for HydratedBloc.
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );

  /// Register the licences for the Google Fonts used in the application.
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/fonts/OFL.txt');

    yield LicenseEntryWithLineBreaks(['fonts'], license);
  });

  /// Load translation files for multi-language support.
  await IntlTranslation.loadJsons();

  /// Initialize Hive.
  await initHiveOpenBox();

  /// Set the status bar to be transparent with light icons.
  /// This allows the app's content to be displayed behind the status bar.
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  /// Lock the screen orientation to portrait mode.
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  /// Initialize Dependencies Injection.
  initIntlDI();
  initThemeDI();
  initAppDI();
  initNetworkDI(
    baseUrl: baseUrl,
    tokenProvider: () => sI<AuthBloc>().getJwtToken,
  );
  initApiClientDI();
  initAuthDI();

  // App Bloc Observer
  Bloc.observer = const AppBlocObserver();

  runApp(KelasQNAApp());
}
