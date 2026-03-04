import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:mocktail/mocktail.dart';

class MockSessionsLocalDataSource extends Mock
    implements SessionsLocalDataSource {}

class MockSessionsRemoteDataSource extends Mock
    implements SessionsRemoteDataSource {}

void main() {
  late SessionsRepositoryImpl repository;
  late MockSessionsLocalDataSource mockLocalDataSource;
  late MockSessionsRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockLocalDataSource = MockSessionsLocalDataSource();
    mockRemoteDataSource = MockSessionsRemoteDataSource();
    repository = SessionsRepositoryImpl(
      mockLocalDataSource,
      mockRemoteDataSource,
    );
  });

  group('isLoggedIn', () {
    test('should return true when there is a token in local storage', () async {
      // arrange
      when(
        () => mockLocalDataSource.getAccessToken(),
      ).thenAnswer((_) async => 'some_token');

      // act
      final result = await repository.isLoggedIn();

      // assert
      expect(result, true);
      verify(() => mockLocalDataSource.getAccessToken()).called(1);
    });

    test(
      'should return false when there is NO token in local storage',
      () async {
        // arrange
        when(
          () => mockLocalDataSource.getAccessToken(),
        ).thenAnswer((_) async => null);

        // act
        final result = await repository.isLoggedIn();

        // assert
        expect(result, false);
      },
    );
  });

  group('getAccessToken', () {
    test('should call local data source to get token', () async {
      // arrange
      const tToken = 'my_token';
      when(
        () => mockLocalDataSource.getAccessToken(),
      ).thenAnswer((_) async => tToken);

      // act
      final result = await repository.getAccessToken();

      // assert
      expect(result, tToken);
      verify(() => mockLocalDataSource.getAccessToken()).called(1);
    });
  });

  group('saveAccessToken', () {
    test('should call local data source to save token', () async {
      // arrange
      const tToken = 'new_token';
      when(
        () => mockLocalDataSource.saveAccessToken(any()),
      ).thenAnswer((_) async => unit);

      // act
      await repository.saveAccessToken(tToken);

      // assert
      verify(() => mockLocalDataSource.saveAccessToken(tToken)).called(1);
    });
  });

  group('clearSession', () {
    test(
      'should call local data source to clear session',
      () async {
        // arrange
        when(() => mockLocalDataSource.clearSession())
            .thenAnswer((_) async => unit);

        // act
        await repository.clearSession();

        // assert
        verify(() => mockLocalDataSource.clearSession()).called(1);
      },
    );
  });

  group('isFirstTimeUserOpenApp', () {
    test(
      'should call local data source to check if it is first time user',
      () async {
        // arrange
        when(() => mockLocalDataSource.isFirstTimeUserOpenApp())
            .thenAnswer((_) async => true);

        // act
        final result = await repository.isFirstTimeUserOpenApp();

        // assert
        expect(result, true);
        verify(() => mockLocalDataSource.isFirstTimeUserOpenApp()).called(1);
      },
    );
  });

  group('setFirstTimeUserOpenedApp', () {
    test(
      'should call local data source to set first time user opened app',
      () async {
        // arrange
        when(() => mockLocalDataSource.setIsFirstTimeUserOpenedApp(any()))
            .thenAnswer((_) async => unit);

        // act
        await repository.setFirstTimeUserOpenedApp(false);

        // assert
        verify(() => mockLocalDataSource.setIsFirstTimeUserOpenedApp(false))
            .called(1);
      },
    );
  });

  group('me', () {
    final tUserModel = UserModel(
      id: 1,
      name: 'Test User',
      email: 'test@example.com',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final tUserEntity = tUserModel.toEntity();

    test(
      'should return Right(UserEntity) when remote data source is successful',
      () async {
        // arrange
        when(
          () => mockRemoteDataSource.me(),
        ).thenAnswer((_) async => Right(tUserModel));

        // act
        final result = await repository.me();

        // assert
        expect(result, Right(tUserEntity));
        verify(() => mockRemoteDataSource.me()).called(1);
      },
    );

    test(
      'should return Left(Failure) when remote data source is unsuccessful',
      () async {
        // arrange
        const tFailure = Failure.server(errorMessage: 'Unauthorized');
        when(
          () => mockRemoteDataSource.me(),
        ).thenAnswer((_) async => const Left(tFailure));

        // act
        final result = await repository.me();

        // assert
        expect(result, const Left(tFailure));
        verify(() => mockRemoteDataSource.me()).called(1);
      },
    );
  });
}
