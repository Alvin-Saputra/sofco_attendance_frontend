import 'package:attendance_frontend/core/utils/api_result.dart';
import 'package:attendance_frontend/features/attendance/data/datasources/attendance_datasources.dart';
import 'package:attendance_frontend/features/attendance/data/models/fetch_attendance_response.dart';
import 'package:attendance_frontend/features/attendance/domain/repositories/attendance_repository.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceDatasources attendanceDatasources;

  AttendanceRepositoryImpl(this.attendanceDatasources);
  @override
  Future<ApiResult<FetchAttendanceResponse>> fetchAttendance(int userId) async {
    try {
      final response = await attendanceDatasources.fetchAttendance(userId);
      return Success(response);
    } catch (e) {
      final errorMessage = e.toString().replaceAll('Exception', '');
      return Error(errorMessage);
    }
  }
}
