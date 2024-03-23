import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String createdAt;
  final String name;
  final String avatar;

  const User({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  const User.empty()
      : id = '0',
        createdAt = 'empty_createdAt',
        name = 'empty_name',
        avatar = 'empty_avtar';

  @override
  List<Object?> get props => [id, createdAt, name, avatar];
}
