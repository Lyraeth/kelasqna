import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/core/api/failures/failure.dart';

typedef Result<T> = Either<Failure, T>;

typedef FromJson<T> = T Function(Map<String, dynamic> json);