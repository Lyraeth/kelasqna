import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:kelasqna/core/api/failures/failure.dart';

typedef Result<T> = Either<Failure, T>;

final sI = GetIt.instance;
