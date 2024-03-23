import 'package:dartz/dartz.dart';
import 'package:flutter_clean_articuture/core/errors/api_failure.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef ResultVoid = Future<void>;
typedef DataMapSD = Map<String,dynamic>;
