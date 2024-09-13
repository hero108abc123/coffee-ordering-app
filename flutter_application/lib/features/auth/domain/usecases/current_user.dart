import 'package:flutter_application/core/common/entities/user_profile.dart';
import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/core/usecase/usecase.dart';
import 'package:flutter_application/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements Usecase<Profile, NoParams> {
  final AuthRepository authRepository;
  CurrentUser(this.authRepository);

  @override
  Future<Either<Failure, Profile>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
