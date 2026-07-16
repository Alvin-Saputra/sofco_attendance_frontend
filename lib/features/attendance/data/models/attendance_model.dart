import 'package:attendance_frontend/features/attendance/domain/entities/attendance.dart';

class AttendanceModel extends Attendance {
  AttendanceModel({
    required super.id,
    required super.userId,
    required super.date,
    required super.time,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      id: json['id'],
      userId: json['user_id'],
      date: json['date'],
      time: json['time'],
    );
  }
}
