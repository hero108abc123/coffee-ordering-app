import 'package:flutter_application/core/common/entities/user.dart';
import 'package:flutter_application/core/common/entities/user_profile.dart';
import 'package:flutter_application/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> signUp({
    required String userName,
    required String mobileNumber,
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> signIn({
    required String email,
    required String password,
  });

  Future<Either<Failure, String>> forgotPassword({
    required String email,
  });

  Future<Either<Failure, Profile>> currentUser();
}
