// ignore_for_file: unused_field

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_articuture/src/authentication/domain/entites/user.dart';
import 'package:flutter_clean_articuture/src/authentication/domain/use_cases/create_user.dart';
import 'package:flutter_clean_articuture/src/authentication/domain/use_cases/get_user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required CreateUser createUser,
    required GetUsers getUsers,
  })  : _createUser = createUser,
        _getUsers = getUsers,
        super(const AuthenticationInitial()) {
    on<CreateUserEvent>(_createUserHandler);
    on<GetUserEvent>(_getUsersHandler);
  }

  final CreateUser _createUser;
  final GetUsers _getUsers;

  Future<void> _createUserHandler(
    CreateUserEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const CreatingUser());
    final result = await _createUser(
      CreateUserParams(
        createdAt: event.createdAt,
        name: event.name,
        avtar: event.avatar,
      ),
    );

    result.fold(
      (failure) => emit(
        AuthenticationError(failure.errorMessage),
      ),
      (r) => emit(const UsersCreated()),
    );
  }

  Future<void> _getUsersHandler(
    GetUserEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const GettingUsers());
    final result = await _getUsers();
    result.fold(
      (failure) => failure.errorMessage,
      (users) => emit(UsersLoaded(users)),
    );
  }
}
