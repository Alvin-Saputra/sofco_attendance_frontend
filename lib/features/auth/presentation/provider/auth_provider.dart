import 'package:attendance_frontend/core/utils/shared_prefs_provider.dart';
import 'package:attendance_frontend/features/auth/data/datasources/local/auth_local_datasources.dart';
import 'package:attendance_frontend/features/auth/data/datasources/remote/auth_remote_datasources.dart';
import 'package:attendance_frontend/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:attendance_frontend/features/auth/domain/repositories/auth_repository.dart';
import 'package:attendance_frontend/features/auth/domain/usecases/login_use_case.dart';
import 'package:attendance_frontend/routes/app_routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDatasources>((ref) {
  return AuthRemoteDatasources();
});
final authLocalDataSourceProvider = Provider<AuthLocalDatasources>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return AuthLocalDatasources(prefs);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  final localDataSource = ref.watch(authLocalDataSourceProvider);
  return AuthRepositoryImpl(remoteDataSource, localDataSource);
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LoginUseCase(repository);
});


final initialRouteProvider = FutureProvider<String>((ref) async {
  final repository = ref.watch(authRepositoryProvider);
  
  // Ambil token dan userId melalui repository (bukan langsung ke shared preferences)
  final token = await repository.getToken();
  final userId = await repository.getUserId();

  if (token != null && userId != null) {
  bool isTokenExpired = JwtDecoder.isExpired(token);

  if(isTokenExpired){
    await repository.clearAuthData();
    return AppRoutes.login;
  }

    return AppRoutes.home; // Ganti dengan rute halaman utama kamu (misal: '/home')
  } else {
    return AppRoutes.login;
  }
});

