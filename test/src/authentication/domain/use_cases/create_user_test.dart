// what does the class depand on
// arrange  act assert

import 'package:dartz/dartz.dart';
import 'package:flutter_clean_articuture/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:flutter_clean_articuture/src/authentication/domain/use_cases/create_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  late CreateUser useCase;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthenticationRepository();
    useCase = CreateUser(repository);
  });

  const params = CreateUserParams.empty();

  test(
    'should  call the  [AuthRepo.createUser]',
    () async {
      // arrange
      when(
        () => repository.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avtar'),
        ),
      ).thenAnswer(
        (_) async => const Right(null),
      );

      // act
      final result = await useCase(params);

      // assert
      expect(result, equals(const Right<dynamic, void>(null)));

      verify(
        () => repository.createUser(
          createdAt: params.createdAt,
          name: params.name,
          avatar: params.avtar,
        ),
      ).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
