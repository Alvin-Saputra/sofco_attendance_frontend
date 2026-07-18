import 'package:attendance_frontend/core/utils/api_result.dart';
import 'package:attendance_frontend/features/auth/domain/entities/auth_entity.dart';
import 'package:attendance_frontend/features/auth/domain/repositories/auth_repository.dart';
import 'package:attendance_frontend/features/auth/presentation/provider/auth_state.dart';
import 'package:attendance_frontend/features/auth/presentation/provider/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends Notifier<AuthState> {
  late final AuthRepository _repository;
  @override
  AuthState build() {
    _repository = ref.watch(authRepositoryProvider);
    _loadUserData();
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
      state = AuthState();
      state = state.copyWith(status: AuthStatus.initial, message: e.toString());
      print('=== DEBUG ERROR TERTANGKAP ===');
      print('Error Asli: $e');
      print('Titik Lokasi (Stack Trace):\n$stackTrace');
    }
  }

  Future<void> _loadUserData() async {
    try {
      final token = await _repository.getToken();
      final userId = await _repository.getUserId();
      final userName = await _repository.getUserName(); // Menggunakan 'N' besar

      if (token != null && userId != null && userName != null) {
        state = state.copyWith(
          status: AuthStatus.authenticated,
          user: AuthEntity(token: token, id: userId, username: userName),
        );
      }
      else{
        state = state.copyWith(
          status: AuthStatus.unauthenticated
        );
      }
    } catch (e) {
        state = state.copyWith(
          status: AuthStatus.error
        );
    }
  }

  Future<void> logout() async {
    try{
 await _repository.clearAuthData();
    state =
        state = state.copyWith(
          status: AuthStatus.unauthenticated
        );
    }catch (e){
      state = state.copyWith(
        status: AuthStatus.error,
        message: "Gagal menghapus session. Silakan coba lagi"
      );
    }
   
  }
}

final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});
