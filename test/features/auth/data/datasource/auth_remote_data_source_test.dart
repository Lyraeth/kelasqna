import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:mocktail/mocktail.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  late AuthRemoteDataSourceImpl dataSource;
  late MockApiClient mockApiClient;

  setUpAll(() async {
    // Mock the .env file for testing
    dotenv.loadFromString(
      envString: "DATABASE_URL_LOCAL=http://localhost:8000",
    );
  });

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = AuthRemoteDataSourceImpl(mockApiClient);
  });

  group('login', () {
    const tLoginRequest = LoginRequest(
      email: 'test@example.com',
      password: 'password',
      deviceName: 'test_device',
    );

    final tLoginResponse = {
      "error": false,
      "tokens": {
        "access_token": "token123",
        "token_type": "Bearer",
        "expires_at": "2023-12-31T23:59:59Z",
      },
    };

    test(
      'should perform a POST request on a URL with login request body',
      () async {
        // arrange
        when(
          () => mockApiClient.post(any(), data: any(named: 'data')),
        ).thenAnswer((_) async => Right(tLoginResponse));

        // act
        await dataSource.login(tLoginRequest);

        // assert
        verify(
          () => mockApiClient.post(loginUrl, data: tLoginRequest.toJson()),
        ).called(1);
      },
    );

    test(
      'should return LoginResponse when the response code is 200 (success)',
      () async {
        // arrange
        when(
          () => mockApiClient.post(any(), data: any(named: 'data')),
        ).thenAnswer((_) async => Right(tLoginResponse));

        // act
        final result = await dataSource.login(tLoginRequest);

        // assert
        expect(result.isRight(), true);
        result.fold((l) => fail('Should be Right'), (r) {
          expect(r.tokens.accessToken, "token123");
          expect(r.error, false);
        });
      },
    );

    test('should return Failure when the response is an error', () async {
      // arrange
      const tFailure = Failure.server(errorMessage: 'Invalid credentials');
      when(
        () => mockApiClient.post(any(), data: any(named: 'data')),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await dataSource.login(tLoginRequest);

      // assert
      expect(result, const Left(tFailure));
    });
  });

  group('logout', () {
    test('should perform a POST request to logoutUrl', () async {
      // arrange
      when(
        () => mockApiClient.post(any(), data: any(named: 'data')),
      ).thenAnswer((_) async => const Right({}));

      // act
      final result = await dataSource.logout();

      // assert
      verify(() => mockApiClient.post(logoutUrl, data: {})).called(1);
      expect(result, unit);
    });
  });
}
