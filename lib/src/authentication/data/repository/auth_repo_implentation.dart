import 'package:dartz/dartz.dart';
import 'package:flutter_clean_articuture/core/errors/api_failure.dart';
import 'package:flutter_clean_articuture/core/errors/api_exception.dart';
import 'package:flutter_clean_articuture/core/utils/typedef.dart';
import 'package:flutter_clean_articuture/src/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_clean_articuture/src/authentication/domain/entites/user.dart';
import 'package:flutter_clean_articuture/src/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImplentation implements AuthenticationRepository {
  const AuthenticationRepositoryImplentation(this._remoteDataSource);

  final AuthenticationRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    try {
      await _remoteDataSource.createUser(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      );
      return const Right(null);
    } on APIException catch (e) {
      return Left(
        ApiFailure.fromException(e),
      );
    }
  }

  @override
  ResultFuture<List<User>> getUser() async {
    try {
      final list = await _remoteDataSource.getUsers();
      return Right(list);
    } on APIException catch (e) {
      return Left(
        ApiFailure.fromException(e),
      );
    }
  }
}
