// ignore_for_file: unused_local_variable

import 'package:dartz/dartz.dart';

import 'package:flutter_clean_articuture/core/errors/api_failure.dart';
import 'package:flutter_clean_articuture/core/errors/api_exception.dart';
import 'package:flutter_clean_articuture/src/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_clean_articuture/src/authentication/data/models/user_models.dart';
import 'package:flutter_clean_articuture/src/authentication/data/repository/auth_repo_implentation.dart';
import 'package:flutter_clean_articuture/src/authentication/domain/entites/user.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

class MockRemoteDataSrc extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource remoteDataSource;
  late AuthenticationRepositoryImplentation authRepoImpl;

  setUp(
    () {
      remoteDataSource = MockRemoteDataSrc();
      authRepoImpl = AuthenticationRepositoryImplentation(remoteDataSource);
    },
  );

  group(
    'create user',
    () {
      const createdAt = 'createdAt';
      const name = 'ansh raj';
      const avatar = 'avatar';

      const tException = APIException(
        message: 'exception occured',
        statusCode: 500,
      );

      test(
        'should call the remoteDataSource and complete successfully when the call to the remote source is successful',
        () async {
          // arrange
          when(() => remoteDataSource.createUser(
                createdAt: 'createdAt',
                name: 'ansh raj',
                avatar: 'avatar',
              )).thenAnswer((_) async => Future.value());

          // act

          final result = await authRepoImpl.createUser(
            createdAt: createdAt,
            name: name,
            avatar: avatar,
          );

          // assert
          expect(result, equals(const Right(null)));

          verify(
            () => remoteDataSource.createUser(
              createdAt: createdAt,
              name: name,
              avatar: avatar,
            ),
          ).called(1);

          verifyNoMoreInteractions(remoteDataSource);
        },
      );

      test(
        'should return server failure when the call to the remote',
        () async {
          const tException = APIException(
            message: 'exception occured',
            statusCode: 500,
          );

          // act
          when(
            () => remoteDataSource.createUser(
              createdAt: createdAt,
              name: name,
              avatar: avatar,
            ),
          ).thenThrow(tException);

          // arrange
          final result = await authRepoImpl.createUser(
            createdAt: createdAt,
            name: name,
            avatar: avatar,
          );

          // assert
          expect(
              result,
              equals(
                Left(
                  ApiFailure(
                    message: tException.message,
                    statusCode: tException.statusCode,
                  ),
                ),
              ));

          verify(
            () {
              return remoteDataSource.createUser(
                  createdAt: createdAt, name: name, avatar: avatar);
            },
          ).called(1);

          verifyNoMoreInteractions(remoteDataSource);
        },
      );

      test(
        'should return list<user> when repo.getUsers called',
        () async {
          // act
          when(
            () => remoteDataSource.getUsers(),
          ).thenAnswer(
            (_) async => [],
          );

          // arrange
          final result = await authRepoImpl.getUser();

          expect(result, isA<Right<dynamic, List<User>>>());

          verify(() => remoteDataSource.getUsers()).called(1);

          verifyNoMoreInteractions(remoteDataSource);
        },
      );
      test(
        'should return failure when repo.getUsers called',
        () async {
          // act
          when(
            () => remoteDataSource.getUsers(),
          ).thenThrow(tException);

          // arrange
          final result = await authRepoImpl.getUser();

          expect(
              result,
              Left(ApiFailure(
                message: tException.message,
                statusCode: tException.statusCode,
              )));

          verify(() => remoteDataSource.getUsers()).called(1);

          verifyNoMoreInteractions(remoteDataSource);
        },
      );
    },
  );
}
