class UserForgotPasswordParams {
  final String email;

  UserForgotPasswordParams({required this.email});
}

class UserSignInParams {
  final String email;
  final String password;

  UserSignInParams({
    required this.email,
    required this.password,
  });
}

class UserSignUpParams {
  final String userName;
  final String mobileNumber;
  final String email;
  final String password;

  UserSignUpParams({
    required this.userName,
    required this.mobileNumber,
    required this.email,
    required this.password,
  });
}
