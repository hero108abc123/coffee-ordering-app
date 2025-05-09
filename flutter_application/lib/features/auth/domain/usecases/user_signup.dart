import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/core/usecase/usecase.dart';
import 'package:flutter_application/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_application/features/auth/domain/usecases/params.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements Usecase<String, UserSignUpParams> {
  final AuthRepository authRepository;
  UserSignUp(this.authRepository);
  @override
  Future<Either<Failure, String>> call(UserSignUpParams params) async {
    return await authRepository.signUp(
      userName: params.userName,
      mobileNumber: params.mobileNumber,
      email: params.email,
      password: params.password,
    );
  }
}
