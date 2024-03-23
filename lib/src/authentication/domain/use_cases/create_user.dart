import 'package:equatable/equatable.dart';
import 'package:flutter_clean_articuture/core/usecase/usecase.dart';
import 'package:flutter_clean_articuture/core/utils/typedef.dart';
import 'package:flutter_clean_articuture/src/authentication/domain/repositories/authentication_repository.dart';

class CreateUser extends UseCaseWithParams<void, CreateUserParams> {
  const CreateUser(this._repository);
  final AuthenticationRepository _repository;

  @override
  ResultFuture<void> call(CreateUserParams params) async =>
      _repository.createUser(
        name: params.name,
        avatar: params.avtar,
        createdAt: params.createdAt,
      );
}

class CreateUserParams extends Equatable {
  final String createdAt;
  final String name;
  final String avtar;

  const CreateUserParams({
    required this.createdAt,
    required this.name,
    required this.avtar,
  });

  const CreateUserParams.empty()
      : createdAt = 'empty_createdAt',
        name = 'empty_name',
        avtar = 'empty_avtar';

  @override
  List<Object?> get props => [createdAt, name, avtar];
}
