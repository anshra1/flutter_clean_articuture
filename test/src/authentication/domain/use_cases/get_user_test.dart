// what does the class depand on
// arrange  act assert

import 'package:dartz/dartz.dart';
import 'package:flutter_clean_articuture/src/authentication/domain/entites/user.dart';
import 'package:flutter_clean_articuture/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:flutter_clean_articuture/src/authentication/domain/use_cases/get_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  late GetUsers useCase;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthenticationRepository();
    useCase = GetUsers(repository);
  });

  const tResponse = [User.empty()];

  test(
    'should  call the  [AuthRepo.getUser] and return [List<User>]',
    () async {
      // arrange
      when(
        () => repository.getUser(),
      ).thenAnswer(
        (_) async => const Right(tResponse),
      );

      // act
      final result = await useCase();

      // assert
      expect(result, equals(const Right<dynamic, List<User>>(tResponse)));

      verify(
        () => repository.getUser(),
      ).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
