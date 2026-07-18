import 'package:attendance_frontend/core/error/exception.dart';
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
    } on ServerException catch (e) {
      if (e.statusCode == 401 || e.statusCode == 404) {
        return Error("Username atau password tidak cocok. Coba lagi");
      } else if (e.statusCode == 500) {
        return Error('Server sedang bermasalah. Mohon coba lagi nanti');
      } else {
        return Error('Gagal melakukan login');
      }
    } on NetworkException {
      return Error('Tidak ada koneksi internet. Silakan periksa jaringan anda');
    } on TimeoutCustomException {
      return Error('Koneksi terputus karena terlalu lama. Coba lagi');
    } catch (e) {
      return Error('Terjadi kesalahan tidak terduga');
    }
  }

  @override
  Future<String?> getToken() async {
    return await authLocalDatasource.getToken();
  }

  @override
  Future<int?> getUserId() async {
    return await authLocalDatasource.getUserId();
  }

  @override
  Future<void> saveToken(String token) async {
    await authLocalDatasource.saveToken(token);
  }

  @override
  Future<void> saveUserId(int userId) async {
    await authLocalDatasource.saveUserId(userId);
  }

  @override
  Future<void> clearAuthData() async {
    await authLocalDatasource.clearAuthData();
  }

  @override
  Future<String?> getUserName() async {
    return await authLocalDatasource.getUserName();
  }

  @override
  Future<void> saveUsername(String userName) async {
    await authLocalDatasource.saveUserName(userName);
  }
}
