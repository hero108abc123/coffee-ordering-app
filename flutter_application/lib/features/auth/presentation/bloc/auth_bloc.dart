import 'package:flutter/material.dart';
import 'package:flutter_application/core/common/cubit/app_user_cubit.dart';
import 'package:flutter_application/core/common/entities/user.dart';
import 'package:flutter_application/core/common/entities/user_profile.dart';
import 'package:flutter_application/core/usecase/usecase.dart';
import 'package:flutter_application/features/auth/domain/usecases/current_user.dart';
import 'package:flutter_application/features/auth/domain/usecases/user_signin.dart';
import 'package:flutter_application/features/auth/domain/usecases/user_signup.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  AuthBloc({
    required UserSignUp userSignUp,
    required UserSignIn userSignIn,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  })  : _userSignUp = userSignUp,
        _userSignIn = userSignIn,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthSignIn>(_onAuthSignIn);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
  }

  void _isUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _currentUser(NoParams());

    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (profile) => _emitAuthSuccess(profile, emit),
    );
  }

  void _onAuthSignIn(
    AuthSignIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _userSignIn(
      UserSignInParams(
        email: event.email,
        password: event.password,
      ),
    );

    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  void _onAuthSignUp(
    AuthSignUp event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _userSignUp(
      UserSignUpParams(
        userName: event.userName,
        mobileNumber: event.mobileNumber,
        email: event.email,
        password: event.password,
      ),
    );

    res.fold(
      (failure) => emit(AccountFailure(failure.message)),
      (status) => emit(AccountSuccess(status)),
    );
  }

  void _emitAuthSuccess(
    Profile profile,
    Emitter<AuthState> emit,
  ) {
    _appUserCubit.updateUser(profile);
    emit(ProfileSuccess(profile));
  }
}
