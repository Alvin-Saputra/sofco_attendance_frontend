import 'package:attendance_frontend/core/utils/api_result.dart';
import 'package:attendance_frontend/features/auth/data/models/login_response.dart';

abstract class AuthRepository {
  Future<ApiResult<LoginResponse>> login(String username, String password);

  Future<String?> getToken();
  Future<void> saveToken(String token);

  Future<void> saveUserId(int userId);
  Future<int?> getUserId();

  Future<void> saveUsername(String username);
  Future<String?> getUserName();

  Future<void> clearAuthData();

}
