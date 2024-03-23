import 'dart:convert';

import 'package:flutter_clean_articuture/core/errors/api_exception.dart';
import 'package:flutter_clean_articuture/core/utils/constants.dart';
import 'package:flutter_clean_articuture/core/utils/typedef.dart';
import 'package:flutter_clean_articuture/src/authentication/data/models/user_models.dart';
import 'package:http/http.dart' as http;

abstract class AuthenticationRemoteDataSource {
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  Future<List<UserModel>> getUsers();
}

const kCreatedUserEndpoint = 'test-api/users';
const kGetUsersEndPoint = 'test-api/user';

class AuthRemoteDataSourcImpl implements AuthenticationRemoteDataSource {
  final http.Client client;

  const AuthRemoteDataSourcImpl({required this.client});

  @override
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    try {
      final response = await client.post(
        Uri.https(kBaseUrl, kCreatedUserEndpoint),
        body: jsonEncode(
          {
            'createdAt': createdAt,
            'name': name,
            'avatar': avatar,
          },
        ),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await client.get(Uri.https(kBaseUrl, kGetUsersEndPoint));

      if (response.statusCode != 200) {
        throw APIException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }

      return List<dynamic>.from(jsonDecode(response.body) as List)
          .map((userData) => UserModel.fromMap(userData))
          .toList();
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
