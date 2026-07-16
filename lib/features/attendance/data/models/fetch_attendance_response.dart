import 'package:attendance_frontend/features/attendance/data/models/attendance_model.dart';
import 'package:attendance_frontend/features/attendance/domain/entities/attendance.dart';

class FetchAttendanceResponse {
  final String status;
  final String message;
  final List<Attendance> items;

  FetchAttendanceResponse({
    required this.status,
    required this.message,
    required this.items,
  });

  factory FetchAttendanceResponse.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'] as List?;

    List<Attendance> data = [];
    if (rawData != null) {
      data = rawData.map((items) => AttendanceModel.fromJson(items)).toList();
    }
    return FetchAttendanceResponse(
      status: json['status'],
      message: json['message'],
      items: data,
    );
  }
}
