import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/core/usecase/usecase.dart';
import 'package:flutter_application/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserForgotPassword implements Usecase<String, UserForgotPasswordParams> {
  final AuthRepository _authRepository;
  UserForgotPassword(this._authRepository);

  Future<Either<Failure, String>> call(UserForgotPasswordParams params) async {
    return await _authRepository.forgotPassword(
      email: params.email,
    );
  }
}

class UserForgotPasswordParams {
  final String email;

  UserForgotPasswordParams({required this.email});
}
