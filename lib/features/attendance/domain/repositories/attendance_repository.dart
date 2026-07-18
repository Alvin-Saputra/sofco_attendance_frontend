import 'dart:io';

import 'package:attendance_frontend/core/utils/api_result.dart';
import 'package:attendance_frontend/features/attendance/data/models/check_attendance_response.dart';
import 'package:attendance_frontend/features/attendance/data/models/create_attendance_response.dart';
import 'package:attendance_frontend/features/attendance/data/models/fetch_attendance_response.dart';

abstract class AttendanceRepository {
  Future<ApiResult<FetchAttendanceResponse>> fetchAttendance();
  Future<ApiResult<CheckAttendanceResponse>> checkAttendance(String date);
  Future<ApiResult<CreateAttendanceResponse>> createAttendance({
    required String date,
    required String time,
    required File image,
  });
}
