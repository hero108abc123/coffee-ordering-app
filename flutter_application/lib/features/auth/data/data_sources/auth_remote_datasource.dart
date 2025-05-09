import 'package:dio/dio.dart';
import 'package:flutter_application/core/error/exceptions.dart';
import 'package:flutter_application/core/network/constants/endpoints.dart';
import 'package:flutter_application/core/network/remote/dio_client.dart';
import 'package:flutter_application/features/auth/data/models/user_model.dart';
import 'package:flutter_application/features/auth/data/models/user_profile_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> signUp({
    required String userName,
    required String mobileNumber,
    required String email,
    required String password,
  });
  Future<UserModel> signIn({
    required String email,
    required String password,
  });

  Future<String> forgotPassword({
    required String email,
  });

  Future<ProfileModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient _dio;
  static const storage = FlutterSecureStorage();
  AuthRemoteDataSourceImpl(this._dio);

  @override
  Future<ProfileModel?> getCurrentUserData() async {
    try {
      Response response = await _dio.get(
        "${Endpoints.user}/get-user",
        isAuthorize: true,
      );
      return ProfileModel.fromJson(response.data);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      Response response = await _dio.post(
        "${Endpoints.auth}/login",
        data: {
          "email": email,
          "password": password,
        },
      );
      await storage.write(key: 'token', value: response.data['token']);
      return UserModel.fromJson(response.data);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> signUp({
    required String userName,
    required String mobileNumber,
    required String email,
    required String password,
  }) async {
    try {
      Response response = await _dio.post(
        "${Endpoints.auth}/create",
        data: {
          "userName": userName,
          "mobileNumber": mobileNumber,
          "email": email,
          "password": password,
        },
      );
      return response.data;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> forgotPassword({required String email}) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }
}
