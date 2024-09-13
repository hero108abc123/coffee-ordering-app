import 'package:fpdart/fpdart.dart';

import '../error/failure.dart';

abstract interface class Usecase<SuccesType, Params> {
  Future<Either<Failure, SuccesType>> call(Params params);
}

class NoParams {}
