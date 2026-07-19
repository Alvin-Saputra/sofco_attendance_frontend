import 'package:attendance_frontend/core/components/attendance_card.dart';
import 'package:attendance_frontend/core/constant/app_text_size.dart';
import 'package:attendance_frontend/core/utils/date_parser.dart';
import 'package:attendance_frontend/core/utils/time_parser.dart';
import 'package:attendance_frontend/features/attendance/presentation/providers/check_attendance_notifier.dart';
import 'package:attendance_frontend/features/attendance/presentation/providers/fetch_attendance_notifier.dart';
import 'package:attendance_frontend/features/attendance/presentation/providers/fetch_attendance_state.dart';
import 'package:attendance_frontend/features/attendance/presentation/providers/result_state.dart';
import 'package:attendance_frontend/features/attendance/presentation/screens/attendance_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AttendanceHistoryScreen extends ConsumerStatefulWidget {
  const AttendanceHistoryScreen({super.key});

  @override
  ConsumerState<AttendanceHistoryScreen> createState() =>
      _AttendanceHistoryScreenState();
}

// 2. Ubah State menjadi ConsumerState
class _AttendanceHistoryScreenState
    extends ConsumerState<AttendanceHistoryScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      String _current = DateParser.dateToString(
        DateTime.now(),
        pattern: "yyyy-MM-dd",
      );
      ref.read(fetchAttendanceNotifierProvider.notifier).fetchAttendance();
      ref
          .read(checkAttendanceNotifierProvider.notifier)
          .checkAttendance(_current);
    });
  }

  @override
  Widget build(BuildContext context) {
    final attendanceState = ref.watch(fetchAttendanceNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Attendance History")),
      body: _buildBodyContent(attendanceState),
    );
  }

  Widget _buildBodyContent(FetchAttendanceState attendanceState) {
    switch (attendanceState.state) {
      case ResultState.loading:
        return Center(child: CircularProgressIndicator());

      case ResultState.success:
        return ListView.builder(
          itemCount: attendanceState.attendanceList.length,
          itemBuilder: (context, index) {
            return AttendanceCard(
              title: DateParser.dateToString(
                attendanceState.attendanceList[index].date,
                pattern: 'dd MMM yyyy',
              ),
              subtitle: TimeParser.timeOfDaytoString(
                attendanceState.attendanceList[index].time,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AttendanceDetailScreen(
                      attendanceItem: attendanceState.attendanceList[index],
                    ),
                  ),
                );
              },
            );
          },
        );

      case ResultState.empty:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "No Attendance Data",
                style: TextStyle(
                  fontSize: AppTextSize.textLg,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );

      case ResultState.error:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                attendanceState.message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: AppTextSize.textLg,
                  fontWeight: FontWeight.bold,
                  
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(fetchAttendanceNotifierProvider.notifier)
                      .fetchAttendance();
                },
                child: Text("Retry"),
              ),
            ],
          ),
        );

      case ResultState.initial:
      default:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "No Attendance Data",
                style: TextStyle(
                  fontSize: AppTextSize.textLg,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
    }
  }
}
