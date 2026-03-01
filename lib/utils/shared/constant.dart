import 'dart:ui';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final sI = GetIt.instance;

final FlutterSecureStorage secureStorage = FlutterSecureStorage(
  aOptions: AndroidOptions(),
);

const Color primaryBlue = Color.fromARGB(255, 120, 149, 178);
const Color secondaryBlue = Color.fromARGB(255, 174, 189, 202);
const Color primaryBackground = Color.fromARGB(255, 245, 239, 230);
const Color secondaryBackground = Color.fromARGB(255, 232, 223, 202);
