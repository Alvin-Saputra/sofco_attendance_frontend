import 'package:attendance_frontend/core/utils/api_result.dart';
import 'package:attendance_frontend/features/attendance/data/models/fetch_attendance_response.dart';

abstract class AttendanceRepository {
  Future<ApiResult<FetchAttendanceResponse>> fetchAttendance(int userId);
}