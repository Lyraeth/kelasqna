part of 'api_client.dart';

const _flavor = String.fromEnvironment('FLAVOR', defaultValue: 'staging');

String normalize(String base) =>
    base.endsWith('/') ? base.substring(0, base.length - 1) : base;

final String baseUrl =
    dotenv.env['DATABASE_URL'] ??
    (throw Exception("DATABASE_URL not found in .env"));

final String baseLocalUrl =
    dotenv.env['DATABASE_URL_LOCAL'] ??
    (throw Exception("DATABASE_URL_LOCAL not found in .env"));

final String selectedBaseUrl = _flavor == 'production' ? baseUrl : baseLocalUrl;

/// No need to change this manually
/// [selectedBaseUrl] will automatically change based on flavor.
final String databaseUrl = "${normalize(selectedBaseUrl)}/api";

final String loginUrl = "$databaseUrl/login";

final String logoutUrl = "$databaseUrl/logout";

final String registerUrl = "$databaseUrl/register";

final String meUrl = "$databaseUrl/me";

final String questionsUrl = "$databaseUrl/questions";

final String sessionsUrl = "$databaseUrl/sessions";

final String userUrl = "$databaseUrl/users";

final String notificationsUrl = "$databaseUrl/notifications";

final String deviceTokenUrl = "$databaseUrl/device-tokens";
