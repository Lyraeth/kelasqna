part of 'api_client.dart';

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

final String logoutUrl = "$databaseUrl/logout";

final String registerUrl = "$databaseUrl/register";

final String meUrl = "$databaseUrl/me";

final String questionsUrl = "$databaseUrl/questions";

final String sessionsUrl = "$databaseUrl/sessions";

final String userUrl = "$databaseUrl/users";

final String notificationsUrl = "$databaseUrl/notifications";

final String deviceTokenUrl = "$databaseUrl/device-tokens";
