
import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool isPassword; 

  const CustomInputField({
    required this.label,
    required this.controller,
    this.validator,
    this.keyboardType,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    // Dekorasi yang sama seperti sebelumnya
    final inputDecoration = InputDecoration(
      filled: true,
      fillColor: Color.fromARGB(255, 239, 239, 239),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32.0),
        borderSide: const BorderSide(color: Color.fromARGB(255, 239, 239, 239), width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32.0),
        borderSide: const BorderSide(color: Color.fromARGB(255, 52, 52, 52), width: 2.0),
      ),
      // Kita gunakan hintText karena label sudah ada di luar
      hintText: 'Enter $label',
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- LABEL MANUAL ---
        Text(
          label,
          style: TextStyle(
            fontSize:16, fontWeight: FontWeight.w600,
            color: Color.fromARGB(255, 39, 39, 39),
          )
        ),
        const SizedBox(height: 8.0), 
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          decoration: inputDecoration,
          obscureText: isPassword,
        ),
      ],
    );
  }
}
