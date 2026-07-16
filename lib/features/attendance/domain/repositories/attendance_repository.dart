import 'dart:io';

import 'package:attendance_frontend/core/utils/api_result.dart';
import 'package:attendance_frontend/features/attendance/data/models/create_attendance_response.dart';
import 'package:attendance_frontend/features/attendance/data/models/fetch_attendance_response.dart';

abstract class AttendanceRepository {
  Future<ApiResult<FetchAttendanceResponse>> fetchAttendance(int userId);
  Future<ApiResult<CreateAttendanceResponse>> createAttendance({
    required int userId,
    required String date,
    required String time,
    required File image,
  });
}
