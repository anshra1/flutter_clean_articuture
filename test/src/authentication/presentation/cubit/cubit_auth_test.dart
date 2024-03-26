import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_articuture/core/errors/api_failure.dart';
import 'package:flutter_clean_articuture/src/authentication/domain/use_cases/create_user.dart';
import 'package:flutter_clean_articuture/src/authentication/domain/use_cases/get_user.dart';
import 'package:flutter_clean_articuture/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetUsers extends Mock implements GetUsers {}

class MockCreateUsers extends Mock implements CreateUser {}

void main() {
  late GetUsers getUsers;
  late CreateUser createUser;
  late AuthenticationCubit cubit;

  const tCreateUserParams = CreateUserParams.empty();
  const tApiFailure = ApiFailure(message: 'api failure', statusCode: 400);

  setUp(() {
    getUsers = MockGetUsers();
    createUser = MockCreateUsers();
    cubit = AuthenticationCubit(createUser: createUser, getUsers: getUsers);
    registerFallbackValue(tCreateUserParams);
  });

  tearDown(() => cubit.close());

  test(
    'intial state should be Authentication.Intial',
    () {
      expect(cubit.state, const AuthenticationInitial());
    },
  );

  group(
    'create user',
    () {
      blocTest<AuthenticationCubit, AuthenticationState>(
        'should emit [creating,userCreated] when sucessful',
        build: () {
          // arrange
          when(() {
            return createUser(any());
          }).thenAnswer((invocation) async => const Right(null));
          return cubit;
        },
        // act
        act: (cubit) => cubit.createUser(
          createdAt: tCreateUserParams.createdAt,
          name: tCreateUserParams.name,
          avatar: tCreateUserParams.avtar,
        ),

        expect: () => const [
          CreatingUser(),
          UsersCreated(),
        ],
        verify: (_) {
          createUser(tCreateUserParams);
          //  verifyNoMoreInteractions(createUser);
        },
      );
      blocTest<AuthenticationCubit, AuthenticationState>(
          'should emit [creating,AuthenticationError] when unsucessful',
          build: () {
            // arrange
            when(() {
              return createUser(any());
            }).thenAnswer((_) async => const Left(tApiFailure));
            return cubit;
          },

          // act
          act: (cubit) => cubit.createUser(
                createdAt: tCreateUserParams.createdAt,
                name: tCreateUserParams.name,
                avatar: tCreateUserParams.avtar,
              ),
          expect: () => [
                const CreatingUser(),
                AuthenticationError(tApiFailure.errorMessage),
              ],
          verify: (_) {
            createUser(tCreateUserParams);
            //   verifyNoMoreInteractions(createUser);
          });
    },
  );

  group(
    'getUser',
    () {
      blocTest<AuthenticationCubit, AuthenticationState>(
        'should emit [gettingUsers,userLoaded] when sucessful',
        build: () {
          // arrange
          when(() {
            return getUsers();
          }).thenAnswer((invocation) async => const Right([]));
          return cubit;
        },
        // act
        act: (cubit) => cubit.getUsers(),

        expect: () => const [
          GettingUsers(),
          UsersLoaded([]),
        ],
        verify: (_) {
          verify(() => getUsers()).called(1);
          //  verifyNoMoreInteractions(getUsers);
        },
      );

// Update the createUser method in the test file to correct the typo
      const tApiFailure = ApiFailure(message: 'api failure', statusCode: 400);
      blocTest<AuthenticationCubit, AuthenticationState>(
          'should emit [gettingUsers,AuthenticationError] when unsuccessful',
          build: () {
            // arrange
            when(() {
              return getUsers();
            }).thenAnswer((_) async => const Left(tApiFailure));
            return cubit;
          },

          // act
          act: (cubit) => cubit.getUsers(),
          expect: () => [
                const GettingUsers(),
                AuthenticationError(tApiFailure.errorMessage),
              ],
          verify: (_) {
            // verify(() => getUsers()).called(1);
            // verifyNoMoreInteractions(getUsers);
          });
    },
  );
}
