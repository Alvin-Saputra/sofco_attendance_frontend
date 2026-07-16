
import 'package:attendance_frontend/features/attendance/presentation/screens/attendance_history_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const attendanceHistory = '/attendanceHistory';
  // static const recordAttendance = '/recordAttendance',

  static Map<String, WidgetBuilder> get routes =>{
    attendanceHistory: (context) => const AttendanceHistoryScreen(),
  };
}