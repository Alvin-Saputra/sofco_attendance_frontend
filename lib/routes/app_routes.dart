
import 'package:attendance_frontend/features/attendance/presentation/screens/attendance_history_screen.dart';
import 'package:attendance_frontend/features/attendance/presentation/screens/attendance_record_screen.dart';
import 'package:attendance_frontend/features/attendance/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const attendanceHistory = '/attendanceHistory';
  static const attendanceRecord = '/attendanceRecord';
  static const home = '/home';
  // static const recordAttendance = '/recordAttendance',

  static Map<String, WidgetBuilder> get routes =>{
    attendanceHistory: (context) => const AttendanceHistoryScreen(),
    attendanceRecord: (context) => const AttendanceRecordScreen(),
    home: (context) => const HomeScreen(),
  };
}