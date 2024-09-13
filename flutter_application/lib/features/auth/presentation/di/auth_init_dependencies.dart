import 'package:flutter_application/core/common/cubit/app_user_cubit.dart';
import 'package:flutter_application/core/network/module/network_module.dart';
import 'package:flutter_application/core/network/remote/dio_client.dart';
import 'package:flutter_application/features/auth/data/data_sources/auth_remote_datasource.dart';
import 'package:flutter_application/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_application/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_application/features/auth/domain/usecases/current_user.dart';
import 'package:flutter_application/features/auth/domain/usecases/user_signin.dart';
import 'package:flutter_application/features/auth/domain/usecases/user_signup.dart';
import 'package:flutter_application/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;
Future<void> authInitDependencies() async {
  _initAuth();
  //core
  serviceLocator.registerLazySingleton(() => NetworkModule.provideDio());
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  serviceLocator
    ..registerFactory<DioClient>(
      () => DioClient(
        serviceLocator(),
      ),
    )
    //Data Source
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )

    //Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
      ),
    )

    // Service
    ..registerFactory(
      () => CurrentUser(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSignUp(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSignIn(
        serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userSignIn: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}
