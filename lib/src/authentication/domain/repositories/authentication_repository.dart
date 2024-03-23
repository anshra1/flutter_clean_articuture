import 'package:flutter_clean_articuture/core/utils/typedef.dart';
import 'package:flutter_clean_articuture/src/authentication/domain/entites/user.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

   ResultFuture<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  ResultFuture<List<User>> getUser();
}
