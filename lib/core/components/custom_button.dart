import 'package:attendance_frontend/core/constant/app_colors.dart';
import 'package:attendance_frontend/core/constant/app_text_size.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onPressed, this.isDisable = false, required this.childWidget});

  final Function()? onPressed;
  final bool isDisable;
  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (isDisable)?null:onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: (isDisable)?Colors.grey:AppColors.secondary,
        foregroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            8.0,
          ), // Ubah angka ini sesuai kebutuhan
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: childWidget
        ),
      ),
    );
  }
}
