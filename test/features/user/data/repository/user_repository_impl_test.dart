import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRemoteDataSource extends Mock implements UserRemoteDataSource {}

void main() {
  late UserRepositoryImpl repository;
  late MockUserRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockUserRemoteDataSource();
    repository = UserRepositoryImpl(mockRemoteDataSource);
  });

  group('register', () {
    const tRegisterParams = UserRegisterParams(
      name: 'Test User',
      email: 'test@example.com',
      password: 'password123',
      passwordConfirmation: 'password123',
    );

    const tRegisterRequest = RegisterRequest(
      name: 'Test User',
      email: 'test@example.com',
      password: 'password123',
      passwordConfirmation: 'password123',
    );

    final tRegisterResponse = RegisterResponse(
      error: false,
      message: 'User registered successfully',
      userModel: UserModel(
        id: 1,
        name: 'Test User',
        email: 'test@example.com',
        createdAt: DateTime.now(),
        role: UserRole.student,
      ),
    );

    test(
      'should return Right(RegisterResponse) when remote data source is successful',
      () async {
        // arrange
        when(
          () => mockRemoteDataSource.register(any()),
        ).thenAnswer((_) async => Right(tRegisterResponse));

        // act
        final result = await repository.register(tRegisterParams);

        // assert
        expect(result, Right(tRegisterResponse));
        verify(() => mockRemoteDataSource.register(tRegisterRequest)).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test(
      'should return Left(Failure) when remote data source is unsuccessful',
      () async {
        // arrange
        const tFailure = Failure.server(errorMessage: 'Registration failed');
        when(
          () => mockRemoteDataSource.register(any()),
        ).thenAnswer((_) async => const Left(tFailure));

        // act
        final result = await repository.register(tRegisterParams);

        // assert
        expect(result, const Left(tFailure));
        verify(() => mockRemoteDataSource.register(tRegisterRequest)).called(1);
      },
    );
  });

  setUpAll(() {
    registerFallbackValue(
      const RegisterRequest(
        name: '',
        email: '',
        password: '',
        passwordConfirmation: '',
      ),
    );
  });
}
