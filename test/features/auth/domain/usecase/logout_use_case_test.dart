import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late LogoutUseCase useCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = LogoutUseCase(mockAuthRepository);
  });

  test(
    'should call logout from the repository',
    () async {
      // arrange
      when(() => mockAuthRepository.logout())
          .thenAnswer((_) async => unit);

      // act
      await useCase.call();

      // assert
      verify(() => mockAuthRepository.logout()).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );
}
