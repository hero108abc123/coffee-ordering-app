part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final User user;
  AuthSuccess(this.user);
}

final class ProfileFailure extends AuthState {
  final String message;
  ProfileFailure(this.message);
}

final class ProfileSuccess extends AuthState {
  final Profile profile;
  ProfileSuccess(this.profile);
}

final class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}

final class AccountFailure extends AuthState {
  final String message;
  AccountFailure(this.message);
}

final class AccountSuccess extends AuthState {
  final String message;
  AccountSuccess(this.message);
}
