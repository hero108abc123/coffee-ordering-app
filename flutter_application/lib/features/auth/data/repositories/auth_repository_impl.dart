import 'package:flutter_application/core/common/entities/user.dart';
import 'package:flutter_application/core/common/entities/user_profile.dart';
import 'package:flutter_application/core/error/exceptions.dart';
import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/features/auth/data/data_sources/auth_remote_datasource.dart';
import 'package:flutter_application/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, Profile>> currentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUserData();

      if (user == null) {
        return left(Failure("User not logged in!"));
      }

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> signIn({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.signIn(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, String>> signUp({
    required String userName,
    required String mobileNumber,
    required String email,
    required String password,
  }) async {
    try {
      final accountSuccess = await remoteDataSource.signUp(
        userName: userName,
        mobileNumber: mobileNumber,
        email: email,
        password: password,
      );
      if (accountSuccess != "Create account success") {
        return left(Failure("Something went wrong!"));
      }
      return right(accountSuccess);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  Future<Either<Failure, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    try {
      final user = await fn();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword({
    required String email,
  }) {
    throw UnimplementedError();
  }
}
