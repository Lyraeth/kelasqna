import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

abstract class SessionsRepository {
  /// Fetches the profile information of the currently authenticated user.
  ///
  /// Returns a [Result] containing [UserEntity] on success, or a failure message on error.
  Future<Result<UserEntity>> me();

  /// Retrieves the stored access token from secure storage.
  ///
  /// Returns the token as a [String], or `null` if no token is found.
  Future<String?> getAccessToken();

  /// Persists the provided access token to secure storage for future authentication.
  ///
  /// [value] is the access token to be saved.
  Future<Unit> saveAccessToken(String value);

  /// Clears the active session by removing all stored authentication credentials.
  Future<Unit> clearSession();

  /// Checks if there is currently an active user session.
  ///
  /// Returns `true` if the user is logged in, and `false` otherwise.
  Future<bool> isLoggedIn();

  /// Retrieves the stored user details from Hive.
  ///
  /// Return the user details as a [UserEntity], or `null` if no user detail is found.
  UserEntity? getLoggedUserDetails();

  /// Persists the provided user details to Hive.
  ///
  /// [userEntity] is the user details to be saved.
  Future<Unit> saveLoggedUserDetails(UserEntity userEntity);

  /// Checks whether this is the first time the user has opened the application.
  ///
  /// Returns `true` if it is the first launch, and `false` otherwise.
  Future<bool> isFirstTimeUserOpenApp();

  /// Updates the status indicating whether the user has opened the application.
  ///
  /// [value] is the flag to set, typically `false` after the initial onboarding.
  Future<Unit> setFirstTimeUserOpenedApp(bool value);
}
