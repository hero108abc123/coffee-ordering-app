import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/core/usecase/usecase.dart';
import 'package:flutter_application/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_application/features/auth/domain/usecases/params.dart';
import 'package:fpdart/fpdart.dart';

class UserForgotPassword implements Usecase<String, UserForgotPasswordParams> {
  final AuthRepository _authRepository;
  UserForgotPassword(this._authRepository);

  @override
  Future<Either<Failure, String>> call(UserForgotPasswordParams params) async {
    return await _authRepository.forgotPassword(
      email: params.email,
    );
  }
}
