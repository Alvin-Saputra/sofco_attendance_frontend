import 'package:attendance_frontend/features/auth/domain/entities/auth_entity.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState {
  final AuthStatus status;
  final AuthEntity? user;
  final String message;

  AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.message = '',
  });

   AuthState copyWith({
    AuthStatus? status,
    AuthEntity? user,
    String? message,
ndanceList,
  }) {
    return AuthState(
     status: status ?? this.status,
     user: user ?? this.user,
     message: message ?? this.message,
    );
  }
}