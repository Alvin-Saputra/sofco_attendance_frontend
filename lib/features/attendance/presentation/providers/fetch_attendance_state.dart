import 'package:attendance_frontend/features/attendance/domain/entities/attendance.dart';
import 'package:attendance_frontend/features/attendance/presentation/providers/result_state.dart';


class FetchAttendanceState {
  final ResultState state;
  final String message;
  final List<Attendance> attendanceList;

  FetchAttendanceState({
    this.state = ResultState.initial,
    this.message = '',
    this.attendanceList = const [],
  });

  FetchAttendanceState copyWith({
    ResultState? state,
    String? message,
    List<Attendance>? attendanceList,
  }) {
    return FetchAttendanceState(
      state: state ?? this.state,
      message: message ?? this.message,
      attendanceList: attendanceList ?? this.attendanceList,
    );
  }
}
