import 'package:flutter/material.dart';
import 'package:student_management/repository/auth_repository.dart';
import 'package:student_management/ui/auth/auth_header.dart';
import 'package:student_management/ui/component/button/sm_elevated_button.dart';
import 'package:student_management/ui/component/loading.dart';
import 'package:student_management/ui/component/text/medium_text.dart';
import 'package:student_management/ui/component/text/small_text.dart';
import 'package:student_management/ui/component/text_field/sm_auth_password_text_field.dart';
import 'package:student_management/ui/component/text_field/sm_auth_text_field.dart';
import 'package:student_management/utils/colors.dart';

class RegisterScreen extends StatefulWidget {

  final Function() toggleView;

  const RegisterScreen({super.key, required this.toggleView});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthRepository _authRepository = AuthRepository();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text filed state
  String fullName = "";
  String email = "";
  String password = "";
  String confirmPassword = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() : Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            const AuthHeader(desc: "Register to start your journey!"),
            SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                      key: _formKey,
                      child: Column(children: [
                        SmAuthTextField(
                            onChanged: (value) {
                              setState(() {
                                fullName = value;
                              });
                            },
                            validator: (value) {
                              if(value == null || value.isEmpty) {
                                return "Please enter your full name";
                              }
                              return null;
                            },
                            placeholder: "Full name",
                            hint: "JohnDoe"),
                        const SizedBox(height: 16),
                        SmAuthTextField(
                            onChanged: (value) {
                              setState(() {
                                email = value;
                              });
                            },
                            validator: (value) {
                              if(value == null || value.isEmpty) {
                                return "Please enter your email";
                              }
                              return null;
                            },
                            placeholder: "Email",
                            hint: "email@example.com"),
                        const SizedBox(height: 16),
                        SmAuthPasswordTextField(
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                            validator: (value) {
                              if(value == null || value.isEmpty) {
                                return "Please enter your password";
                              }
                              return null;
                            },
                            placeholder: "Password",
                            hint: "********"),
                        const SizedBox(height: 16),
                        SmAuthPasswordTextField(
                            onChanged: (value) {
                              setState(() {
                                confirmPassword = value;
                              });
                            },
                            validator: (value) {
                              if(value == null || value.isEmpty) {
                                return "Please enter your confirm password";
                              } else if(value != password) {
                                return "Confirm password does not match";
                              }
                              return null;
                            },
                            placeholder: "Confirm password",
                            hint: "********"),
                        const SizedBox(height: 24),
                      ])),
                  SmElevatedButton(
                    text: "Register",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        dynamic result = await _authRepository
                            .registerWithEmailAndPassword(email, password, fullName);
                        if (result == null) {
                          setState(() {
                            loading = false;
                            error = "Please supply a valid email";
                          });
                        }
                      }
                    },
                  ),
                  if (error.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    SmallText(text: error)
                  ] else ...[
                    const SizedBox(height: 0)
                  ],
                  const SizedBox(height: 16),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        widget.toggleView();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          MediumText(
                              text: "Have an account?",
                              color: AppColors.neutral70,
                              fontWeight: FontWeight.w400),
                          MediumText(
                              text: "Login",
                              color: AppColors.neutral90,
                              fontWeight: FontWeight.w600),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
