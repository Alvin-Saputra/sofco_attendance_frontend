import 'package:attendance_frontend/core/utils/api_result.dart';
import 'package:attendance_frontend/features/auth/presentation/provider/auth_state.dart';
import 'package:attendance_frontend/features/auth/presentation/provider/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    return AuthState();
  }

  Future<void> login(String username, String password) async {
    state = state.copyWith(status: AuthStatus.loading);

    try {
      final useCase = ref.read(loginUseCaseProvider);
      final result = await useCase.execute(username, password);

      switch (result) {
        case Success():
          state = state.copyWith(
            status: AuthStatus.authenticated,
            user: result.data.authData,
          );

        case Error():
          state = state.copyWith(
            status: AuthStatus.error,
            message: result.message,
          );
      }
    } catch (e, stackTrace) {
      print('=== DEBUG ERROR TERTANGKAP ===');
      print('Error Asli: $e');
      print('Titik Lokasi (Stack Trace):\n$stackTrace');
    }
  }
}

final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});
