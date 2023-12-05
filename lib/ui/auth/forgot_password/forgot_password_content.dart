import 'package:flutter/material.dart';
import 'package:student_management/repository/auth_repository.dart';
import 'package:student_management/ui/auth/forgot_password/check_mail_screen.dart';
import 'package:student_management/ui/component/button/sm_elevated_button.dart';
import 'package:student_management/ui/component/loading.dart';
import 'package:student_management/ui/component/text/medium_text.dart';
import 'package:student_management/ui/component/text_field/sm_auth_text_field.dart';

class ForgotPasswordContent extends StatefulWidget {
  const ForgotPasswordContent({super.key});

  @override
  State<ForgotPasswordContent> createState() => _ForgotPasswordContentState();
}

class _ForgotPasswordContentState extends State<ForgotPasswordContent> {
  final AuthRepository _authRepository = AuthRepository();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = "";

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Column(
            children: [
              Form(
                  key: _formKey,
                  child: SmAuthTextField(
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your email";
                        }
                        return null;
                      },
                      placeholder: "Email",
                      hint: "email@example.com")),
              const SizedBox(height: 40),
              SmElevatedButton(
                  text: "Send",
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        loading = true;
                      });
                    }
                    dynamic result =
                        await _authRepository.resetPassword(email: email);
                    if (result == false) {
                      setState(() {
                        loading = false;
                      });
                    } else {
                      print("mounted: $mounted");
                      if (mounted) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CheckMailScreen()));
                      }
                    }
                  }),
              const SizedBox(height: 24),
              MediumText(
                text: "Back to login",
                fontWeight: FontWeight.w600,
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
  }
}
