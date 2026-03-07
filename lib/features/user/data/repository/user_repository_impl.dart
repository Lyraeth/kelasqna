import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _userRemoteDataSource;

  UserRepositoryImpl(this._userRemoteDataSource);

  @override
  Future<Result<RegisterResponse>> register(
    UserRegisterParams registerParams,
  ) async {
    final response = await _userRemoteDataSource.register(
      RegisterRequest(
        name: registerParams.name,
        email: registerParams.email,
        password: registerParams.password,
        passwordConfirmation: registerParams.passwordConfirmation,
      ),
    );

    return response.match((failure) => Left(failure), (
      RegisterResponse registerResponse,
    ) {
      return Right(registerResponse);
    });
  }
}
