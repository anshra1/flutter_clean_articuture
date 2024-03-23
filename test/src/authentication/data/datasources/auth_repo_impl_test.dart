import 'dart:convert';

import 'package:flutter_clean_articuture/core/errors/api_exception.dart';
import 'package:flutter_clean_articuture/core/utils/constants.dart';
import 'package:flutter_clean_articuture/src/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_clean_articuture/src/authentication/data/models/user_models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthenticationRemoteDataSource remoteDataSource;

  setUp(
    () {
      client = MockClient();
      remoteDataSource = AuthRemoteDataSourcImpl(client: client);
      registerFallbackValue(Uri());
    },
  );
  group(
    'create user',
    () {
      test(
        'should complete sucessfully when the status code is 200 or 201',
        () async {
          when(
            () => client.post(
              any(),
              body: any(named: 'body'),
            ),
          ).thenAnswer(
            (_) async => http.Response(
              'User created sucessfully',
              201,
            ),
          );

          final methodCall = remoteDataSource.createUser;

          expect(
            methodCall(
              avatar: 'avatar',
              name: 'name',
              createdAt: 'created At',
            ),
            completes,
          );

          verify(
            () => client.post(
              Uri.https(kBaseUrl, kCreatedUserEndpoint),
              body: jsonEncode({
                'createdAt': 'created At',
                'name': 'name',
                'avatar': 'avatar',
              }),
            ),
          ).called(1);

          verifyNoMoreInteractions(client);
        },
      );
      test(
        'show throw api Exception when the status code is not 200 or 201',
        () async {
          when(
            () => client.post(
              any(),
              body: any(named: 'body'),
            ),
          ).thenAnswer(
            (_) async => http.Response(
              'invalid email address',
              400,
            ),
          );

          final methodCall = remoteDataSource.createUser;

          expect(
            () => methodCall(
              avatar: 'avatar',
              name: 'name',
              createdAt: 'created At',
            ),
            throwsA(
              const APIException(
                message: 'invalid email address',
                statusCode: 400,
              ),
            ),
          );

          verify(
            () => client.post(
              Uri.https(kBaseUrl, kCreatedUserEndpoint),
              body: jsonEncode({
                'createdAt': 'created At',
                'name': 'name',
                'avatar': 'avatar',
              }),
            ),
          ).called(1);

          verifyNoMoreInteractions(client);
        },
      );
    },
  );
  group(
    'get user',
    () {
      test(
        'should return list<user> when the status code is 200',
        () async {
          const tUsers = [UserModel.empty()];
          // arrange
          when(
            () => client.get(any()),
          ).thenAnswer(
            (_) async => http.Response(
              jsonEncode([tUsers.first.toMap()]),
              200,
            ),
          );
          // act
          final result = await remoteDataSource.getUsers();
          // assert
          expect(result, equals(tUsers));

          verify(() => client.get(Uri.https(kBaseUrl, kGetUsersEndPoint)))
              .called(1);

          verifyNoMoreInteractions(client);
        },
      );
      test(
        'throw api Exception when the status code is not 200 or 201',
        () async {
          when(
            () => client.get(
              any(),
            ),
          ).thenAnswer(
            (_) async => http.Response(
              'server down',
              500,
            ),
          );

          final result = remoteDataSource.getUsers;

          expect(
            () => result(),
            throwsA(
              const APIException(
                message: 'server down',
                statusCode: 500,
              ),
            ),
          );

          verify(() => client.get(Uri.https(kBaseUrl, kGetUsersEndPoint)))
              .called(1);
          verifyNoMoreInteractions(client);
        },
      );
    },
  );
}
