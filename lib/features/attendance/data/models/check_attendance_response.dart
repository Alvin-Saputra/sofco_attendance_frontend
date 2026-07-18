import 'package:attendance_frontend/features/attendance/data/models/attendance_model.dart';
import 'package:attendance_frontend/features/attendance/domain/entities/attendance.dart';
import 'package:attendance_frontend/features/attendance/domain/entities/attendance_status.dart';

class CheckAttendanceResponse {
  final String status;
  final String message;
  final AttendanceStatus data;

  CheckAttendanceResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CheckAttendanceResponse.fromJson(Map<String, dynamic> json) {
    return CheckAttendanceResponse(
      status: json['status'],
      message: json['message'],
      data: AttendanceStatus(attended: json['data']['attended']??false,),
    );
  }
}
