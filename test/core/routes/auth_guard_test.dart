import 'package:auto_route/auto_route.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:mocktail/mocktail.dart';

class MockSessionsRepository extends Mock implements SessionsRepository {}

class MockNavigationResolver extends Mock implements NavigationResolver {}

class MockStackRouter extends Mock implements StackRouter {}

void main() {
  late AuthGuard authGuard;
  late MockSessionsRepository mockSessionsRepository;
  late MockNavigationResolver mockResolver;
  late MockStackRouter mockRouter;

  setUp(() {
    mockSessionsRepository = MockSessionsRepository();
    authGuard = AuthGuard(mockSessionsRepository);
    mockResolver = MockNavigationResolver();
    mockRouter = MockStackRouter();

    // Default mock behavior
    when(() => mockResolver.next(any())).thenReturn(null);
    when(() => mockRouter.replaceAll(any())).thenAnswer((_) async => []);
  });

  group('AuthGuard', () {
    test('should call resolver.next(true) when user is logged in', () async {
      // arrange
      when(
        () => mockSessionsRepository.isLoggedIn(),
      ).thenAnswer((_) async => true);

      // act
      await authGuard.onNavigation(mockResolver, mockRouter);

      // assert
      verify(() => mockSessionsRepository.isLoggedIn()).called(1);
      verify(() => mockResolver.next(true)).called(1);
      verifyNever(() => mockRouter.replaceAll(any()));
    });

    test('should redirect to LoginRoute when user is NOT logged in', () async {
      // arrange
      when(
        () => mockSessionsRepository.isLoggedIn(),
      ).thenAnswer((_) async => false);

      // act
      await authGuard.onNavigation(mockResolver, mockRouter);

      // assert
      verify(() => mockSessionsRepository.isLoggedIn()).called(1);
      verifyNever(() => mockResolver.next(any()));
      verify(() => mockRouter.replaceAll([const LoginRoute()])).called(1);
    });
  });
}
