import 'package:attendance_frontend/core/utils/api_result.dart';
import 'package:attendance_frontend/features/auth/data/models/login_response.dart';

abstract class AuthRepository {
  Future<ApiResult<LoginResponse>> login(String username, String password);
}