import 'package:attendance_frontend/core/utils/api_result.dart';
import 'package:attendance_frontend/features/attendance/data/models/fetch_attendance_response.dart';
import 'package:attendance_frontend/features/attendance/domain/repositories/attendance_repository.dart';

class FetchAttendanceUseCase {
  final AttendanceRepository repository;

  FetchAttendanceUseCase(this.repository);

  Future<ApiResult<FetchAttendanceResponse>> execute(userId){
    return repository.fetchAttendance(userId);
  }
}