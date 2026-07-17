
import 'package:attendance_frontend/features/attendance/presentation/screens/Success_screen.dart';
import 'package:attendance_frontend/features/attendance/presentation/screens/attendance_history_screen.dart';
import 'package:attendance_frontend/features/attendance/presentation/screens/attendance_create_screen.dart';
import 'package:attendance_frontend/features/attendance/presentation/screens/home_screen.dart';
import 'package:attendance_frontend/features/auth/presentation/screen/login_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const attendanceHistory = '/attendanceHistory';
  static const attendanceRecord = '/attendanceRecord';
  static const home = '/home';
  static const login = '/login';
  static const success = '/success';
  // static const recordAttendance = '/recordAttendance',

  static Map<String, WidgetBuilder> get routes =>{
    attendanceHistory: (context) => const AttendanceHistoryScreen(),
    attendanceRecord: (context) => const AttendanceCreateScreen(),
    home: (context) => const HomeScreen(),
    login: (context) => const LoginScreen(),
    success: (context) => const SuccessScreen(),
  };
}