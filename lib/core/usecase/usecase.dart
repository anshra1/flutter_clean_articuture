
import 'package:flutter_clean_articuture/core/utils/typedef.dart';

abstract class UseCaseWithParams<Type, Params> {
  const UseCaseWithParams();
  ResultFuture<Type> call(Params params);
}

abstract class UseCaseWithoutParam<Type> {
  const UseCaseWithoutParam();
  ResultFuture<Type> call();
}

