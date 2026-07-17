import 'package:attendance_frontend/features/auth/data/datasources/auth_datasources.dart';
import 'package:attendance_frontend/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:attendance_frontend/features/auth/domain/repositories/auth_repository.dart';
import 'package:attendance_frontend/features/auth/domain/usecases/login_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authDataSourceProvider = Provider<AuthDatasources>((ref) {
  return AuthDatasources();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dataSource = ref.watch(authDataSourceProvider);
  return AuthRepositoryImpl(dataSource);
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LoginUseCase(repository);
});

