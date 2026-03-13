import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late LoginUseCase useCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = LoginUseCase(mockAuthRepository);
  });

  const tLoginParams = LoginParams(
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

  test('should get login response from the repository', () async {
    // arrange
    when(
      () => mockAuthRepository.login(any()),
    ).thenAnswer((_) async => Right(tLoginResponse));

    // act
    final result = await useCase.call(tLoginParams);

    // assert
    expect(result, Right(tLoginResponse));
    verify(() => mockAuthRepository.login(tLoginParams)).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return failure when the repository fails', () async {
    // arrange
    const tFailure = Failure.server(errorMessage: 'Login failed');
    when(
      () => mockAuthRepository.login(any()),
    ).thenAnswer((_) async => const Left(tFailure));

    // act
    final result = await useCase.call(tLoginParams);

    // assert
    expect(result, const Left(tFailure));
    verify(() => mockAuthRepository.login(tLoginParams)).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });

  setUpAll(() {
    registerFallbackValue(
      const LoginParams(email: '', password: '', deviceName: ''),
    );
  });
}
