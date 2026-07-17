import 'package:attendance_frontend/core/components/button.dart';
import 'package:attendance_frontend/core/components/custom_input_field.dart';
import 'package:attendance_frontend/features/auth/presentation/provider/auth_notifier.dart';
import 'package:attendance_frontend/features/auth/presentation/provider/auth_state.dart';
import 'package:attendance_frontend/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    // 1. Validasi form terlebih dahulu
    if (formKey.currentState!.validate()) {
      // 2. Hide keyboard
      FocusScope.of(context).unfocus();
      
      // 3. Panggil fungsi login dari Notifier
      ref.read(authNotifierProvider.notifier).login(
            usernameController.text.trim(),
            passwordController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Memantau perubahan state untuk UI (reactive)
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState.status == AuthStatus.loading;

    // ------------------------------------------------------------------
    // REF.LISTEN: Menangani navigasi dan notifikasi error (Side Effects)
    // ------------------------------------------------------------------
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (next.status == AuthStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.message),
            backgroundColor: Colors.red.shade600,
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else if (next.status == AuthStatus.authenticated) {
        // Navigasi ke halaman utama (ganti '/home' sesuai route Anda)
        // Gunakan pushReplacementNamed atau GoRouter agar user tidak bisa back ke login
        Navigator.of(context).pushReplacementNamed(AppRoutes.home);
      }
    });

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Container(
              //   margin: const EdgeInsets.only(top: 64.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Container(
              //         height: 50,
              //         width: 50,
              //         decoration: BoxDecoration(
                       
              //           borderRadius: BorderRadius.circular(8.0),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Container(
                margin: const EdgeInsets.only(top: 64.0, left: 32.0),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 32.0,
                    right: 32.0,
                    top: 48.0,
                    bottom: 24.0,
                  ),
                  child: Column(
                    children: [
                      CustomInputField(
                        validator: (value) => (value == null || value.isEmpty)
                            ? "Enter Your Username"
                            : null,
                        controller: usernameController,
                        label: 'Username',
                        // Opsional: disable input saat loading
                        // enable: !isLoading, 
                      ),
                      const SizedBox(height: 16.0),
                      CustomInputField(
                        validator: (value) => (value == null || value.isEmpty)
                            ? "Enter Your Password"
                            : null,
                        controller: passwordController,
                        label: 'Password',
                        isPassword: true,
                        // enabled: !isLoading,
                      ),
                      const SizedBox(height: 32.0),
                      
                      // --------------------------------------------------
                      // TOMBOL LOGIN DENGAN LOADING STATE
                      // --------------------------------------------------
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          // Nonaktifkan tombol (null) saat proses loading berlangsung
                          onPressed: isLoading ? null : _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: isLoading
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : const Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    );
  }
}