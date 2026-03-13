import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _userRemoteDataSource;

  UserRepositoryImpl(this._userRemoteDataSource);

  @override
  Future<Result<RegisterResponse>> register(
    UserRegisterParams registerParams,
  ) async {
    final RegisterRequest registerRequest = RegisterRequest(
      name: registerParams.name,
      email: registerParams.email,
      password: registerParams.password,
      passwordConfirmation: registerParams.passwordConfirmation,
      className: registerParams.className,
      classNumber: registerParams.classNumber,
      role: registerParams.role,
      subject: registerParams.subject,
    );

    final response = await _userRemoteDataSource.register(registerRequest);

    return response.match((failure) => Left(failure), (
      RegisterResponse registerResponse,
    ) {
      return Right(registerResponse);
    });
  }

  @override
  Future<Result<UserEntity>> fetchAnotherUser({required int id}) async {
    final response = await _userRemoteDataSource.fetchAnotherUser(id: id);

    return response.match(
      (failure) => Left(failure),
      (UserResponse userResponse) => Right(userResponse.user.toEntity()),
    );
  }
}
