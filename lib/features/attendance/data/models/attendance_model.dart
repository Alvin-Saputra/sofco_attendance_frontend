

import 'package:attendance_frontend/core/utils/date_parser.dart';
import 'package:attendance_frontend/core/utils/time_parser.dart';
import 'package:attendance_frontend/features/attendance/domain/entities/attendance.dart';

class AttendanceModel extends Attendance {
  AttendanceModel({
    required super.id,
    required super.userId,
    required super.date,
    required super.time,
    required super.photoUrl
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      id: json['id'],
      userId: json['user_id'],
      date: DateParser.stringToDate(json['attendance_date'] as String, pattern: 'yyyy-MM-dd'),
      time: TimeParser.fromString(json['attendance_time'] as String), 
      photoUrl: json['photo'],
    );
  }
}
