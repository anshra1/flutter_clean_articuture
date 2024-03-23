import 'dart:convert';
import 'package:flutter_clean_articuture/core/utils/typedef.dart';
import 'package:flutter_clean_articuture/src/authentication/data/models/user_models.dart';
import 'package:flutter_clean_articuture/src/authentication/domain/entites/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'should be a sub class of User',
    () {
      const tModel = UserModel.empty();
      expect(tModel, isA<User>());
    },
  );

  final tjson = fixtures('user.json');
  final tMap = jsonDecode(tjson) as DataMapSD;
  const tModel = UserModel(
    createdAt: '2024-03-22T10:13:41.458Z',
    name: 'Maxine McClure',
    avatar:
        'https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/280.jpg',
    id: '3',
  );

  group(
    'from map',
    () {
      test(
        'should return userModel with the right data',
        () {
          // act
          final result = UserModel.fromMap(tMap);
          expect(result, equals(tModel));
        },
      );
    },
  );

  group(
    'toMap',
    () {
      test(
        'should return a map with the right data',
        () {
          // act
          final result = tModel.toMap();
          // assert
          expect(result, equals(tMap));
        },
      );
      test(
        'should return a JSON with the right data',
        () {
          // act
          final result = tModel.toJson();
          final tJson = jsonEncode({
            "createdAt": "2024-03-22T10:13:41.458Z",
            "name": "Maxine McClure",
            "avatar":
                "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/280.jpg",
            "id": "3"
          });

          // assert
          expect(result, equals(tJson));
        },
      );
    },
  );

  test(
    'copy with',
    () {
      final result = tModel.copyWith(name: 'Paul');
      expect(result.name, equals('Paul'));
    },
  );
}
