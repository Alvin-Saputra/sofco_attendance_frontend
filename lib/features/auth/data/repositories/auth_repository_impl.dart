import 'package:attendance_frontend/core/utils/api_result.dart';
import 'package:attendance_frontend/features/auth/data/datasources/auth_datasources.dart';
import 'package:attendance_frontend/features/auth/data/models/login_response.dart';
import 'package:attendance_frontend/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasources authDatasource;

  AuthRepositoryImpl( this.authDatasource);

  @override
  Future<ApiResult<LoginResponse>> login(
    String username,
    String password,
  ) async {
    try {
      final response = await authDatasource.login(username, password);
      return Success(response);
    } catch (e) {
      final errorMessage = e.toString().replaceAll('Exception', '');
      return Error(errorMessage);
    }
  }
}
