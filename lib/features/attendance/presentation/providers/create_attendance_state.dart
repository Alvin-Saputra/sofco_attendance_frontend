import 'package:attendance_frontend/features/attendance/domain/entities/attendance.dart';
import 'package:attendance_frontend/features/attendance/presentation/providers/fetch_attendance_state.dart';
import 'package:attendance_frontend/features/attendance/presentation/providers/result_state.dart';



class CreateAttendanceState {
  final ResultState state;
  final String message;
  final Attendance? attendanceData;

  CreateAttendanceState({
    this.state = ResultState.initial,
    this.message = '',
    this.attendanceData,
  });

  CreateAttendanceState copyWith({
    ResultState? state,
    String? message,
    Attendance? attendanceData,
  }) {
    return CreateAttendanceState(
      state: state ?? this.state,
      message: message ?? this.message,
      attendanceData: attendanceData ?? this.attendanceData,
    );
  }
}
