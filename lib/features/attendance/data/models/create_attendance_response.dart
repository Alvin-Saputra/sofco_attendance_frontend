import 'package:attendance_frontend/features/attendance/data/models/attendance_model.dart';
import 'package:attendance_frontend/features/attendance/domain/entities/attendance.dart';

class CreateAttendanceResponse {
  final String status;
  final String message;
  final Attendance item;

  CreateAttendanceResponse({
    required this.status,
    required this.message,
    required this.item,
  });

  factory CreateAttendanceResponse.fromJson(Map<String, dynamic> json) {
    return CreateAttendanceResponse(
      status: json['status'],
      message: json['message'],
      item: AttendanceModel.fromJson(json['data']),
    );
  }
}
