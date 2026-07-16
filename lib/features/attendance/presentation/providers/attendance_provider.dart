import 'package:attendance_frontend/features/attendance/data/models/create_attendance_response.dart';
import 'package:attendance_frontend/features/attendance/domain/usecases/create_attendance_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:attendance_frontend/features/attendance/data/datasources/attendance_datasources.dart';
import 'package:attendance_frontend/features/attendance/data/repositories/attendance_repository_impl.dart';
import 'package:attendance_frontend/features/attendance/domain/repositories/attendance_repository.dart';
import 'package:attendance_frontend/features/attendance/domain/usecases/fetch_attendance_use_case.dart';

// 1. Datasource Provider
final attendanceDataSourceProvider = Provider<AttendanceDatasources>((ref) {
  return AttendanceDatasources();
});

// 2. Repository Provider
final attendanceRepositoryProvider = Provider<AttendanceRepository>((ref) {
  final dataSource = ref.watch(attendanceDataSourceProvider);
  return AttendanceRepositoryImpl(dataSource);
});

// 3. UseCase Provider
final fetchAttendanceUseCaseProvider = Provider<FetchAttendanceUseCase>((ref) {
  final repository = ref.watch(attendanceRepositoryProvider);
  return FetchAttendanceUseCase(repository);
});

final createAttendanceUseCaseProvider = Provider<CreateAttendanceUseCase>((ref) {
  final repository = ref.watch(attendanceRepositoryProvider);
  return CreateAttendanceUseCase(repository);
});