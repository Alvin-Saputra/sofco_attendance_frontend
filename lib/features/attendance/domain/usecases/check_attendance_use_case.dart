import 'package:attendance_frontend/core/utils/api_result.dart';
import 'package:attendance_frontend/features/attendance/data/models/check_attendance_response.dart';
import 'package:attendance_frontend/features/attendance/data/models/fetch_attendance_response.dart';
import 'package:attendance_frontend/features/attendance/domain/repositories/attendance_repository.dart';

class CheckAttendanceUseCase {
  final AttendanceRepository repository;

  CheckAttendanceUseCase(this.repository);


  Future<ApiResult<CheckAttendanceResponse>> execute(String date){
    return repository.checkAttendance(date);
  }
}