import 'package:attendance_frontend/features/attendance/domain/entities/attendance.dart';

enum ResultState { initial, loading, success, empty, error }

class AttendanceState {
  final ResultState state;
  final String message;
  final List<Attendance> attendanceList;

  AttendanceState({
    this.state = ResultState.initial,
    this.message = '',
    this.attendanceList = const [],
  });

  AttendanceState copyWith({
    ResultState? state,
    String? message,
    List<Attendance>? attendanceList,
  }) {
    return AttendanceState(
      state: state ?? this.state,
      message: message ?? this.message,
      attendanceList: attendanceList ?? this.attendanceList,
    );
  }
}
