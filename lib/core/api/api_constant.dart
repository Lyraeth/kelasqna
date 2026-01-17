import 'package:flutter_dotenv/flutter_dotenv.dart';

String normalize(String base) =>
    base.endsWith('/') ? base.substring(0, base.length - 1) : base;

final String baseUrl =
    dotenv.env['DATABASE_URL'] ??
    (throw Exception("DATABASE_URL not found in .env"));

final String baseLocalUrl =
    dotenv.env['DATABASE_URL_LOCAL'] ??
        (throw Exception("DATABASE_URL_LOCAL not found in .env"));

// Change baseUrl to baseLocalUrl when debugging.
final String databaseUrl = "${normalize(baseLocalUrl)}/api";

final String loginUrl = "$databaseUrl/login";

final String registerUrl = "$databaseUrl/users";
