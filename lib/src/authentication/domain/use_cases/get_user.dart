import 'package:flutter_clean_articuture/core/usecase/usecase.dart';
import 'package:flutter_clean_articuture/core/utils/typedef.dart';
import 'package:flutter_clean_articuture/src/authentication/domain/entites/user.dart';
import 'package:flutter_clean_articuture/src/authentication/domain/repositories/authentication_repository.dart';

class GetUsers extends UseCaseWithoutParam<List<User>> {
  const GetUsers(this._repository);
  final AuthenticationRepository _repository;

  @override
  ResultFuture<List<User>> call() async => _repository.getUser();
}
