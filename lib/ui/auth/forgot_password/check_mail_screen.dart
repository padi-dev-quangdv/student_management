import 'package:flutter/material.dart';
import 'package:student_management/ui/auth/forgot_password/fotgot_password_header.dart';

import '../../component/text/large_text.dart';

class CheckMailScreen extends StatelessWidget {
  const CheckMailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const ForgotPasswordHeader(
                assetPath: "assets/image/img_check_mail.svg",
                title: "Check your email",
                desc:
                    "We have sent password recovery instruction to your email"),
            const SizedBox(height: 64),
            LargeText(text: "Back to login", onTap: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },)
          ],
        ),
      ),
    );
  }
}
