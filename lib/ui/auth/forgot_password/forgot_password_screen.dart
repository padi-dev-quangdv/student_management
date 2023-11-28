import 'package:flutter/material.dart';
import 'package:student_management/ui/auth/forgot_password/forgot_password_content.dart';
import 'package:student_management/ui/auth/forgot_password/fotgot_password_header.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: const Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             ForgotPasswordHeader(
                 assetPath: "assets/image/img_forgot_password.svg",
                 title: "Forgot password?",
                 desc: "We have sent password recovery instruction to your email."),
            SizedBox(height: 40),
            ForgotPasswordContent()
          ],
        ),
      ),
    );
  }
}
