import 'package:attendance_frontend/core/utils/api_result.dart';
import 'package:attendance_frontend/features/auth/data/models/login_response.dart';
import 'package:attendance_frontend/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<ApiResult<LoginResponse>> execute(String username, String password){
    return repository.login(username, password);
  }
}
