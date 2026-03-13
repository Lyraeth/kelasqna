import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    repository = AuthRepositoryImpl(mockRemoteDataSource);
  });

  group('login', () {
    const tLoginParams = LoginParams(
      email: 'test@example.com',
      password: 'password',
      deviceName: 'test_device',
    );

    const tLoginRequest = LoginRequest(
      email: 'test@example.com',
      password: 'password',
      deviceName: 'test_device',
    );

    final tLoginResponse = LoginResponse(
      error: false,
      tokens: SessionsTokenModel(
        accessToken: 'access_token',
        tokenType: 'Bearer',
        expiresAt: DateTime.now().add(1.hours),
      ),
    );

    test(
      'should return Right(LoginResponse) when remote data source is successful',
      () async {
        // arrange
        when(
          () => mockRemoteDataSource.login(any()),
        ).thenAnswer((_) async => Right(tLoginResponse));

        // act
        final result = await repository.login(tLoginParams);

        // assert
        expect(result, Right(tLoginResponse));
        verify(() => mockRemoteDataSource.login(tLoginRequest)).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test(
      'should return Left(Failure) when remote data source is unsuccessful',
      () async {
        // arrange
        const tFailure = Failure.server(errorMessage: 'Login failed');
        when(
          () => mockRemoteDataSource.login(any()),
        ).thenAnswer((_) async => const Left(tFailure));

        // act
        final result = await repository.login(tLoginParams);

        // assert
        expect(result, const Left(tFailure));
        verify(() => mockRemoteDataSource.login(tLoginRequest)).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );
  });

  setUpAll(() {
    registerFallbackValue(
      const LoginRequest(email: '', password: '', deviceName: ''),
    );
  });
}
