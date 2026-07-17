import 'package:attendance_frontend/core/utils/api_result.dart';
import 'package:attendance_frontend/features/auth/data/datasources/local/auth_local_datasources.dart';
import 'package:attendance_frontend/features/auth/data/datasources/remote/auth_remote_datasources.dart';
import 'package:attendance_frontend/features/auth/data/models/login_response.dart';
import 'package:attendance_frontend/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasources authRemoteDatasource;
  final AuthLocalDatasources authLocalDatasource;

  AuthRepositoryImpl(this.authRemoteDatasource, this.authLocalDatasource);

  @override
  Future<ApiResult<LoginResponse>> login(
    String username,
    String password,
  ) async {
    try {
      final response = await authRemoteDatasource.login(username, password);
      await authLocalDatasource.saveToken(response.authData.token);
      await authLocalDatasource.saveUserId(response.authData.id);
      await authLocalDatasource.saveUserName(response.authData.username);
      return Success(response);
    } catch (e) {
      final errorMessage = e.toString().replaceAll('Exception', '');
      return Error(errorMessage);
    }
  }

  @override
  Future<String?> getToken() async {
    try {
      return await authLocalDatasource.getToken();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int?> getUserId() async {
    try {
      return await authLocalDatasource.getUserId();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveToken(String token) async {
    try {
      await authLocalDatasource.saveToken(token);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveUserId(int userId) async {
    try {
      await authLocalDatasource.saveUserId(userId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> clearAuthData() async {
    try {
      await authLocalDatasource.clearAuthData();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String?> getUserName() async {
    try {
      return await authLocalDatasource.getUserName();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveUsername(String username) async {
    try {
      await authLocalDatasource.saveToken(username);
    } catch (e) {
      rethrow;
    }
  }
}
