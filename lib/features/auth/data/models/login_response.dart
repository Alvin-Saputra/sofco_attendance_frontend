import 'package:attendance_frontend/features/auth/domain/entities/auth_entity.dart';

class LoginResponse {
  final String status;
  final String message;
  final AuthData authData;

  LoginResponse({
    required this.status,
    required this.message,
    required this.authData,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'],
      message: json['message'],
      authData: AuthData.fromJson(json['data']),
    );
  }
}

class AuthData extends AuthEntity {
  AuthData({required super.id, required super.username, required super.token});

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      id: json['id'],
      username: json['username'],
      token: json['token'],
    );
  }
}
