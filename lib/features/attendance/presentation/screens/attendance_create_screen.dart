import 'dart:io';

import 'package:attendance_frontend/core/components/custom_button.dart';
import 'package:attendance_frontend/core/constant/app_colors.dart';
import 'package:attendance_frontend/core/constant/app_text_size.dart';
import 'package:attendance_frontend/core/utils/camera_utils.dart';
import 'package:attendance_frontend/core/utils/date_parser.dart';
import 'package:attendance_frontend/core/utils/time_parser.dart';
import 'package:attendance_frontend/features/attendance/presentation/providers/create_attendance_notifier.dart';
import 'package:attendance_frontend/features/attendance/presentation/providers/create_attendance_state.dart';
import 'package:attendance_frontend/features/attendance/presentation/providers/result_state.dart';
import 'package:attendance_frontend/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

class AttendanceCreateScreen extends ConsumerStatefulWidget {
  const AttendanceCreateScreen({super.key});

  @override
  ConsumerState<AttendanceCreateScreen> createState() =>
      _AttendanceRecordScreenState();
}

class _AttendanceRecordScreenState
    extends ConsumerState<AttendanceCreateScreen> {
  File? _selectedImage;

  Future<void> _onPressedCaputreImage() async {
    final File? image = await CameraUtils.pickImageFromCamera();

    if (!mounted) ;
    setState(() {
      _selectedImage = image;
    });
  }

  Future<void> _createAttendance() async {
    String date = DateParser.dateToString(DateTime.now());
    String time = TimeParser.timeOfDaytoString(TimeOfDay.now());
    ref
        .read(createAttendanceNotifierProvider.notifier)
        .createAttendance(date: date, time: time, image: _selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    final attendanceState = ref.watch(createAttendanceNotifierProvider);
    final isLoading = attendanceState.state == ResultState.loading;

    ref.listen<CreateAttendanceState>(createAttendanceNotifierProvider, (
      previous,
      next,
    ) {
      if (next.state == ResultState.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.message),
            backgroundColor: AppColors.danger,
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else if (next.state == ResultState.success) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.success);
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Attendance Record", style: TextStyle(color: AppColors.tertiary))),
      body: Column(
        children: [
          InkWell(
            onTap: _onPressedCaputreImage,
            borderRadius: BorderRadius.circular(24.0),
            child: Container(
              margin: const EdgeInsets.only(top: 32.0),
              height: 400,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                border: DashedBorder.fromBorderSide(
                  side: const BorderSide(color: Colors.black, width: 1.0),
                  dashLength: 4,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                image: (_selectedImage != null)
                    ? DecorationImage(
                        image: FileImage(_selectedImage!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: Center(
                child: (_selectedImage == null)
                    ? Text(
                        "+ Tap to Take Photo",
                        style: TextStyle(fontSize: AppTextSize.textBase, color:AppColors.tertiary),
                      )
                    : null,
              ),
            ),
          ),

          SizedBox(height: 48),
          Center(
            child: Container(
              width: 200,
              child: CustomButton(
                onPressed: () async {
                  await _createAttendance();
                },
                isDisable: isLoading,
                childWidget: (isLoading)
                    ? CircularProgressIndicator()
                    : Text(
                        "Submit",
                        style: TextStyle(
                          fontSize: AppTextSize.textLg,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
