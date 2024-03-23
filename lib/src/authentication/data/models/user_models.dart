import 'dart:convert';
import 'dart:io';

import 'package:flutter_clean_articuture/core/utils/typedef.dart';
import 'package:flutter_clean_articuture/src/authentication/domain/entites/user.dart';

class UserModel extends User {
  const UserModel({
    required super.createdAt,
    required super.name,
    required super.avatar,
    required super.id,
  });

  const UserModel.empty()
      : this(
          avatar: '',
          id: '',
          name: '',
          createdAt: '',
        );

  UserModel copyWith({
    String? id,
    String? createdAt,
    String? name,
    String? avatar,
  }) {
    return UserModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
    );
  }

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMapSD);

  UserModel.fromMap(DataMapSD map)
      : this(
          createdAt: map['createdAt'] as String,
          name: map['name'] as String,
          avatar: map['avatar'] as String,
          id: map['id'] as String,
        );

  DataMapSD toMap() {
    return {
      "createdAt": createdAt,
      "name": name,
      "avatar": avatar,
      "id": id,
    };
  }

  String toJson() => jsonEncode(toMap());
}

String fixtures(String fileName) =>
    File('test/fixtures/$fileName').readAsStringSync();
