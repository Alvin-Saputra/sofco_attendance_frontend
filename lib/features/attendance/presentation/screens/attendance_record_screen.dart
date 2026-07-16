import 'dart:io';

import 'package:attendance_frontend/core/components/button.dart';
import 'package:attendance_frontend/core/utils/camera_utils.dart';
import 'package:attendance_frontend/core/utils/date_parser.dart';
import 'package:attendance_frontend/core/utils/time_parser.dart';
import 'package:attendance_frontend/features/attendance/presentation/providers/create_attendance_notifier.dart';
import 'package:attendance_frontend/features/attendance/presentation/providers/create_attendance_state.dart';
import 'package:attendance_frontend/features/attendance/presentation/providers/result_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AttendanceRecordScreen extends ConsumerStatefulWidget {
  const AttendanceRecordScreen({super.key});

  @override
  ConsumerState<AttendanceRecordScreen> createState() =>
      _AttendanceRecordScreenState();
}

class _AttendanceRecordScreenState
    extends ConsumerState<AttendanceRecordScreen> {
  File? _selectedImage;

  Future<void> _onPressedCaputreImage() async {
    final File? image = await CameraUtils.pickImageFromCamera();

    if (!mounted) ;
    setState(() {
      _selectedImage = image;
    });
  }

  Future<void> _createAttendance() async {
    String date = "2026-07-16";
    String time = TimeParser.timeOfDaytoString(TimeOfDay.now());
    ref
        .read(createAttendanceNotifierProvider.notifier)
        .createAttendance(date: date, time: time, image: _selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    final attendanceState = ref.watch(createAttendanceNotifierProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("Attendance Record")),
      body: (attendanceState.state == ResultState.loading)
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  width: 150,
                  height: 300,
                  child: (_selectedImage != null)
                      ? Image.file(_selectedImage!)
                      : Center(child: Text("No Image")),
                ),
                Center(
                  child: Button(
                    onPressed: () {
                      _onPressedCaputreImage();
                    },
                    text: 'Take Image',
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Button(
                    onPressed: () async {
                      await _createAttendance();
                    },
                    text: 'Submit',
                  ),
                ),
              ],
            ),
    );
  }
}
