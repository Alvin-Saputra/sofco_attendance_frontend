import 'dart:io';

import 'package:attendance_frontend/core/utils/api_result.dart';
import 'package:attendance_frontend/features/attendance/data/models/create_attendance_response.dart';
import 'package:attendance_frontend/features/attendance/domain/repositories/attendance_repository.dart';

class CreateAttendanceUseCase {
  final AttendanceRepository repository;

  CreateAttendanceUseCase(this.repository);

  Future<ApiResult<CreateAttendanceResponse>> execute({
    required String date,
    required String time,
    required File image,
  }) {
    return repository.createAttendance(
      date: date,
      time: time,
      image: image,
    );
  }
}
