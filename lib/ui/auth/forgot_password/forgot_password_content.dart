import 'package:flutter/material.dart';
import 'package:student_management/ui/auth/forgot_password/check_mail_screen.dart';
import 'package:student_management/ui/component/button/sm_elevated_button.dart';
import 'package:student_management/ui/component/text/medium_text.dart';
import 'package:student_management/ui/component/text_field/sm_auth_text_field.dart';

class ForgotPasswordContent extends StatelessWidget {
  const ForgotPasswordContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //const SmAuthTextField(placeholder: "Email", hint: "email@example.com"),
        const SizedBox(height: 40),
        SmElevatedButton(text: "Send", onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckMailScreen()));
        }),
        const SizedBox(height: 24),
        MediumText(text: "Back to login", fontWeight: FontWeight.w600, onTap: () {
          Navigator.pop(context);
        },)
      ],
    );
  }
}
